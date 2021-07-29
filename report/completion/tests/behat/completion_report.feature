@report @report_completion
Feature: See the completion for items in a course
  In order see completion data
  As a teacher
  I need to view completion report

  Background:
    Given the following "users" exist:
      | username | firstname | lastname    | email                | idnumber | middlename | alternatename | firstnamephonetic | lastnamephonetic |
      | teacher1 | Teacher   | 1           | teacher1@example.com | t1       |            | fred          |                   |                  |
      | student1 | Grainne   | Beauchamp   | student1@example.com | s1       | Ann        | Jill          | Gronya            | Beecham          |
      | student2 | Niamh     | Cholmondely | student2@example.com | s2       | Jane       | Nina          | Nee               | Chumlee          |
    And the following "courses" exist:
      | fullname | shortname | category | enablecompletion |
      | Course 1 | C1        | 0        | 1                |
    And the following "course enrolments" exist:
      | user     | course | role           |
      | teacher1 | C1     | editingteacher |
      | student1 | C1     | student        |
      | student2 | C1     | student        |
    And the following "activities" exist:
      | activity | name       | intro      | course | idnumber | completion | completionview |
      | page     | PageName1  | PageDesc1  | C1     | PAGE1    | 1          | 1              |
    And the following config values are set as admin:
      | fullnamedisplay | firstname |
      | alternativefullnameformat | middlename, alternatename, firstname, lastname |

  @javascript
  Scenario: Go to the completion report
    Given I log in as "teacher1"
    And I am on "Course 1" course homepage
    And I navigate to "Course completion" in current page administration
    And I expand all fieldsets
    And I set the following fields to these values:
      | Page - PageName1 | 1 |
    And I press "Save changes"
    And I am on "Course 1" course homepage
    When I navigate to "Reports > Course completion" in current page administration
    Then I should see "Ann, Jill, Grainne, Beauchamp"
    And I should see "Jane, Nina, Niamh, Cholmondely"

  @javascript
  Scenario: User course profile links to filtered course completion report (MDL-77241)
    Given I log in as "teacher1"
    And I am on "Course 1" course homepage
    When I navigate to course participants
    Then I should see "Ann, Jill, Grainne, Beauchamp" in the "Ann, Jill, Grainne, Beauchamp" "table_row"
    And I click on "Ann, Jill, Grainne, Beauchamp" "link" in the "Ann, Jill, Grainne, Beauchamp" "table_row"
    Then I should see "Course completion" in the "region-main" "region"

  @javascript
  Scenario: User course completion report lists exactly the expected user (MDL-77241)
    Given I log in as "teacher1"
    And I am on "Course 1" course homepage
    And I navigate to "Course completion" in current page administration
    And I expand all fieldsets
    And I set the following fields to these values:
      | Page - PageName1 | 1 |
    And I press "Save changes"
    And I am on "Course 1" course homepage
    When I navigate to course participants
    Then I should see "Jane, Nina, Niamh, Cholmondely" in the "Jane, Nina, Niamh, Cholmondely" "table_row"
    And I click on "Jane, Nina, Niamh, Cholmondely" "link" in the "Jane, Nina, Niamh, Cholmondely" "table_row"
    And I click on "Course completion" "link" in the "region-main" "region"
    Then I should see "Jane, Nina, Niamh, Cholmondely"
    But I should not see "Ann, Jill, Grainne, Beauchamp"
