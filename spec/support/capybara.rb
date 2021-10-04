require 'capybara/rspec'
require 'selenium-webdriver'

Capybara.javascript_driver = :selenium_chrome_headless
Capybara.default_max_wait_time = 5

Capybara.register_driver :selenium_chrome_headless do |app|
  options = ::Selenium::WebDriver::Chrome::Options.new


  options.add_argument('--headless')
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-dev-shm-usage')
  options.add_argument('--window-size=1440,990')
  options.add_argument('--remote-debugging-port=9222')
  options.add_argument('--remote-debugging-address=0.0.0.0')

  driver = Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end
