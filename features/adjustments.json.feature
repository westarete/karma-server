Feature: Adjustments via JSON
  In order to modify and report on karma
  As a client
  I want to be able to read and manipulate user's karma via the JSON API

  Background:
    Given the following users:
      | id  | permalink      | created_at              | updated_at              |
      | 1   | bob            | 2009-09-10 19:55:35 UTC | 2009-09-10 19:55:35 UTC |
      | 2   | harry          | 2009-09-10 13:57:01 UTC | 2009-09-10 13:57:01 UTC |
    And the following buckets:
      | id | permalink  | created_at              | updated_at              |
      | 3  | plants     | 2009-09-10 13:57:14 UTC | 2009-09-10 13:57:14 UTC |
      | 4  | animals    | 2009-09-10 13:57:14 UTC | 2009-09-10 13:57:14 UTC |
    And the following adjustments:
      | id | user_id | bucket_id | value | created_at              | updated_at              |
      | 5  | 1       | 3         | 1     | 2009-09-10 15:06:25 UTC | 2009-09-10 15:06:25 UTC |
      | 6  | 1       | 4         | 2     | 2009-09-10 15:06:32 UTC | 2009-09-10 15:06:32 UTC |
      | 7  | 2       | 3         | 3     | 2009-09-10 15:06:25 UTC | 2009-09-10 15:06:25 UTC |
      | 8  | 2       | 4         | 4     | 2009-09-10 15:06:32 UTC | 2009-09-10 15:06:32 UTC |
      | 9  | 2       | 4         | -1    | 2009-09-10 15:06:32 UTC | 2009-09-10 15:06:32 UTC |

  Scenario: Read list of adjustments
    When I GET "/users/harry/buckets/animals/adjustments.json"
    Then I should get a 200 OK response
    And I should get a JSON response body like:
    """    
      [
        {
          adjustment: {
            id: 8,
            value: 4,
            path: "/users/harry/buckets/animals/adjusmtents/8.json",
            user_permalink: harry,
            bucket_permalink: animals,
            created_at: "2009-09-10T15:06:32Z",
            updated_at: "2009-09-10T15:06:32Z"
          }
        },
        {
          adjustment: {
            id: 9,
            value: -1,
            path: "/users/harry/buckets/animals/adjustments/8.json",
            user_permalink: harry,
            bucket_permalink: animals,
            created_at: "2009-09-10T15:06:32Z",
            updated_at: "2009-09-10T15:06:32Z"
          }
        }
      ]
    """
    
  Scenario: Read list of adjustments when there are none
    Given there are no adjustments
    When I GET "/users/harry/buckets/animals/adjustments.json"
    Then I should get a 200 OK response
    And I should get a JSON response body like:
    """
      []
    """
    
  Scenario: Read adjustment
    When I GET "/users/harry/buckets/animals/adjustments/8.json"
    Then I should get a 200 OK response
    And I should get a JSON response body like:
    """
      adjustment: {
        id: 8,
        value: 4,
        path: "/users/harry/buckets/animals/adjusmtents/8.json",
        user_permalink: harry,
        bucket_permalink: animals,
        created_at: "2009-09-10T15:06:32Z",
        updated_at: "2009-09-10T15:06:32Z"
      }
    """
  
  Scenario: Read a non-existent adjustment
    When I GET "/users/harry/buckets/animals/adjustments/500.json"
    Then I should get a 404 Not Found response
    
  Scenario: Read a non-existing adjustment
    When I GET "/users/harry/buckets/animals/adjustments/300.json"
    Then I should get a 404 Not Found response
    
  Scenario: Read an adjustment with a non-existing bucket
    When I GET "/users/harry/buckets/doesnt-exist/adjustments/300.json"
    Then I should get a 404 Not Found response
    
  Scenario: Read an adjustment with a non-existing user
    When I GET "/users/doesnt-exist/buckets/animals/adjustments/300.json"
    Then I should get a 404 Not Found response
    
  Scenario: Read an adjustment with a non-existing user and bucket
    When I GET "/users/doesnt-exist/buckets/doesnt-exist/adjustments/300.json"
    Then I should get a 404 Not Found response
       
  Scenario: Request a new adjustment
    When I GET "/users/harry/buckets/animals/adjustments/new.json"
    Then I should get a 200 OK response
    And I should get a JSON response body like:
    """
      {
        "adjustment":{
          value: null,
          path: null,
          user_permalink: harry,
          bucket_permalink: animals,
          created_at: "2009-09-10T15:06:32Z",
          updated_at: "2009-09-10T15:06:32Z"
        }
      }
    """
    
  Scenario: Request a new adjustment with a non-existing bucket
    When I GET "/users/harry/buckets/doesnt-exist/adjustments/300.json"
    Then I should get a 404 Not Found response
    
  Scenario: Request a new adjustment with a non-existing user
    When I GET "/users/doesnt-exist/buckets/animals/adjustments/300.json"
    Then I should get a 404 Not Found response
    
  Scenario: Request a new adjustment with a non-existing user and bucket
    When I GET "/users/doesnt-exist/buckets/doesnt-exist/adjustments/300.json"
    Then I should get a 404 Not Found response

  Scenario: Create an adjustment
    When I POST "/users/harry/buckets/animals/adjustments.json" with body "adjustment[value]=2"
    Then I should get a 201 Created response
  
  Scenario: Attempt to create an adjustment with no value
    When I POST "/users/harry/buckets/animals/adjustments.json" with body ""
    Then I should get a 422 Unprocessable Entity response
  
  Scenario: Destroy an adjustment
    When I DELETE "/users/harry/buckets/animals/adjustments/8.json"
    Then I should get a 200 OK response
    And I should get a JSON response body like:
    """
      adjustment: {
        id: 8,
        value: 4,
        path: "/users/harry/buckets/animals/adjustments/8.json",
        user_permalink: harry,
        bucket_permalink: animals,
        created_at: "2009-09-10T15:06:32Z",
        updated_at: "2009-09-10T15:06:32Z"
      }
    """
    
  Scenario: Attempt to destroy a non-existing adjustment
    When I DELETE "/users/harry/buckets/animals/adjustments/300.json"
    Then I should get a 404 Not Found response
    
  Scenario: Attempt to destroy an adjustment with a non-existing bucket
    When I DELETE "/users/harry/buckets/doesnt-exist/adjustments/300.json"
    Then I should get a 404 Not Found response
    
  Scenario: Attempt to destroy an adjustment with a non-existing user
    When I DELETE "/users/doesnt-exist/buckets/animals/adjustments/300.json"
    Then I should get a 404 Not Found response
    
  Scenario: Attempt to destroy an adjustment with a non-existing user and bucket
    When I DELETE "/users/doesnt-exist/buckets/doesnt-exist/adjustments/300.json"
    Then I should get a 404 Not Found response