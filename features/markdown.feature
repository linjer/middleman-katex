Feature: Code blocks in markdown get highlighted

  Scenario: Works with Kramdown
    Given a fixture app "basic-test-app"
    And a file named "config.rb" with:
      """
      set :markdown_engine, :kramdown
      activate :katex
      """
    Given the Server is running at "basic-test-app"
    When I go to "/math.html"
    Then I should see '<body class="math">'

  @nojava
  Scenario: Works with RedCarpet
    Given a fixture app "basic-test-app"
    And a file named "config.rb" with:
      """
      set :markdown_engine, :redcarpet
      set :markdown, :fenced_code_blocks => true
      activate :katex
      """
    Given the Server is running at "basic-test-app"
    When I go to "/math.html"
    Then I should see '<body class="math">'
#    Then I should see '<pre class="highlight plaintext"><code>This is some code'
