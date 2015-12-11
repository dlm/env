# For a Rails project, put this in;
# spec/support/formatters/vim_formatter.rb

class VimFormatter
  RSpec::Core::Formatters.register self, :example_failed

  def initialize(output)
    @output = output
  end

  def example_failed(notification)
    @output << format(notification) + "\n"
  end

  private

  def format(notification)
    length = 160
    main_error = "%s:--FAIL %s" % [notification.example.location, notification.exception.message]
    all_errors = notification.formatted_backtrace.unshift(main_error)
    clean_errors = all_errors.map { |line| p line; line.gsub("\n", " ")[0,length] }
    clean_errors.join("\n")
  end
end
