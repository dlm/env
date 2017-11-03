#!/usr/bin/python
# -*- coding: utf-8 -*-

import os
from collections import namedtuple
import pprint
import json
import sys
import urllib
import argparse
import pickle
from datetime import datetime, timedelta

# weather key from open weather map
weather_key = os.environ.get('OPEN_WEATHER_MAP_KEY')

# the set of zip codes
zip_codes = {
    'na': '',
    'bozeman': '19718',
    'nyc': '10016',
}

# the default location.  Pick one your favorites
default_zip = 'na'

# The file name for caching web requests
cache_file = '/tmp/us/millman/weather'

# set the number of seconds until the cache is stale
seconds_valid = 30

# element to cache.  It is outside the cache object because right now, I do not
# know how to pickle the CacheElt object unless it is in the global scope.
CacheElt = namedtuple('CacheElt', 'stale_time resource')


class Cache:

    def __init__(self, file_name, lifetime):
        ''' Name of the file for storage and the default lifetime of an elt '''
        self.file_name = file_name
        self.default_lifetime = lifetime
        self.elts = {}
        try:
            with open(self.file_name, 'r') as pkl_in:
                self.elts = pickle.load(pkl_in)

            for key, item in self.elts.iteritems():
                if item.stale_time <= datetime.now():
                    del item
        except IOError:
            pass

    def dump(self):
        cache_dir = os.path.dirname(cache_file)
        if not os.path.exists(cache_dir):
            os.makedirs(cache_dir)
        with open(self.file_name, 'w') as pkl_out:
            pickle.dump(self.elts, pkl_out)

    def get(self, key):
        if key in self.elts:
            if self.elts[key].stale_time > datetime.now():
                resource = self.elts[key].resource
                success = True
            else:
                del self.elts[key]
                resource = ''
                success = False
        else:
            resource = ''
            success = False
        return resource, success

    def add(self, key, value, timeout=None):
        if timeout is None:
            timeout = self.default_lifetime
        self.elts[key] = CacheElt(datetime.now()+timedelta(seconds=timeout),
                                  value)


def attribute_for_tag(data, tag, attrib):
    """ Get an element from the data with specified tag and attribute. """
    # get the element
    element = data.getElementsByTagName(tag)

    # check to make sure that we only received 1 element
    if element.length != 1:
        raise RuntimeError('Expected one element with tag %s but found %d'
                           % (tag, element.length))

    # check to see is has the expected attribute
    if not element[0].hasAttribute(attrib):
        raise RuntimeError('The element with tag %s does not have attrib %s'
                           % (tag, attrib))

    return element[0].getAttribute(attrib)


def fetch(url, cache=None):
    """ Fetch the contents of the url from cache (if possible).

    Keyword arguments:
    url -- the url to fetch
    cache -- cache element to check before accessing the url.
    """
    # try to get the weather data from cache
    if cache is not None:
        data, success = cache.get(url)
    else:
        success = False

    # if we were unsuccessful
    if not success:

        # request and fetch the site
        response = urllib.urlopen(url)

        # parse the weather data
        data = json.load(response)

        # cache the data
        cache.add(url, data)

    # return weather data and success of caching.
    return data, success


def construct_url(args, cache=None):

    # if location is na, use the ip to approx location
    if args.location == default_zip:
        # make the request for ip based geo location
        ip_url = 'http://ipinfo.io/json'
        ipinfo, success = fetch(ip_url, cache)

        # get the location
        if args.verbose:
            print "Getting weather for {}".format(ipinfo['city'])

        loc = ipinfo['postal']
    else:
        loc = zip_codes[args.location]

    # use 'imperial' for Fahrenheit
    unit = 'metric'
    weather_url = ('http://api.openweathermap.org/data/2.5/weather?' +
                   'zip={zip},us&appid={weather_key}&units={unit}')
    return weather_url.format(zip=loc, weather_key=weather_key, unit=unit)


def parse_arguments():
    """ Parse the command line arguments. """
    parser = argparse.ArgumentParser()
    parser.add_argument(
        '--verbose',
        help='Increase output verbosity.',
        action="store_true")
    parser.add_argument(
        '--location',
        help="The location for which to get the weather",
        choices=zip_codes.keys(),
        default=default_zip)
    args = parser.parse_args()
    return args


def local_time(unix_time):
    return datetime.fromtimestamp(unix_time).strftime("%H:%M")


def main():
    """ User the arguments and construct and print the weather one liner. """
    # parse the arguments
    args = parse_arguments()

    # create a cache element
    cache = Cache(cache_file, seconds_valid)

    # build the url
    url = construct_url(args, cache)

    # request the site
    weather_data, cached = fetch(url, cache)

    # get the data we want from the site
    fmt_data = {
        "prefix": ('' if cached else '*'),
        "temp": weather_data['main']['temp'],
        "desc": weather_data['weather'][0]['description'],
        "sunrise": local_time(weather_data['sys']['sunrise']),
        "sunset": local_time(weather_data['sys']['sunset']),
    }

    # we have all our data print the output
    if args.verbose:
        pprint.pprint(weather_data)
    print '{prefix}{desc}, {temp}°, [{sunrise}, {sunset}]'.format(**fmt_data)
    cache.dump()


if __name__ == "__main__":
    sys.exit(main())
