Feature: Adjustments via JSON
  In order to modify and report on karma
  As a client
  I want to be able to read and manipulate user's karma via the JSON API

  Scenario: Read list of adjustments
    Given a typical set of adjustments, buckets, and users
    When I GET "/users/harry/buckets/animals/adjustments.json"
    Then I should get a 200 OK response
    And I should get a JSON response body like:
    """    
      [
        {
          adjustment: {
            id: 104,
            value: 4,
            path: "/users/harry/buckets/animals/adjustments/104.json",
            user_permalink: harry,
            bucket_permalink: animals,
            created_at: "2009-09-10T15:06:32Z",
            updated_at: "2009-09-10T15:06:32Z"
          }
        },
        {
          adjustment: {
            id: 105,
            value: -1,
            path: "/users/harry/buckets/animals/adjustments/105.json",
            user_permalink: harry,
            bucket_permalink: animals,
            created_at: "2009-09-10T15:06:32Z",
            updated_at: "2009-09-10T15:06:32Z"
          }
        }
      ]
    """
  
  Scenario: Read list of adjustments when there are none
    Given a typical set of adjustments, buckets, and users
    And there are no adjustments
    When I GET "/users/harry/buckets/animals/adjustments.json"
    Then I should get a 200 OK response
    And I should get a JSON response body like:
    """
      []
    """
  
  Scenario: Read adjustment
    Given a typical set of adjustments, buckets, and users
    When I GET "/users/harry/buckets/animals/adjustments/104.json"
    Then I should get a 200 OK response
    And I should get a JSON response body like:
    """
      adjustment: {
        id: 104,
        value: 4,
        path: "/users/harry/buckets/animals/adjustments/104.json",
        user_permalink: harry,
        bucket_permalink: animals,
        created_at: "2009-09-10T15:06:32Z",
        updated_at: "2009-09-10T15:06:32Z"
      }
    """
  
  Scenario: Read a non-existent adjustment
    When I GET "/users/harry/buckets/animals/adjustments/500.json"
    Then I should get a 404 Not Found response
    And I should get an empty response body
  
  Scenario: Read a non-existing adjustment
    When I GET "/users/harry/buckets/animals/adjustments/300.json"
    Then I should get a 404 Not Found response
    And I should get an empty response body
  
  Scenario: Read an adjustment with a non-existing bucket
    When I GET "/users/harry/buckets/doesnt-exist/adjustments/300.json"
    Then I should get a 404 Not Found response
    And I should get an empty response body
  
  Scenario: Read an adjustment with a non-existing user
    When I GET "/users/doesnt-exist/buckets/animals/adjustments/300.json"
    Then I should get a 404 Not Found response
    And I should get an empty response body
  
  Scenario: Read an adjustment with a non-existing user and bucket
    When I GET "/users/doesnt-exist/buckets/doesnt-exist/adjustments/300.json"
    Then I should get a 404 Not Found response
    And I should get an empty response body
  
  Scenario: Request a new adjustment
    Given a typical set of adjustments, buckets, and users
    When I GET "/users/harry/buckets/animals/adjustments/new.json"
    Then I should get a 200 OK response
    And I should get a JSON response body like:
    """
      {
        "adjustment":{
          id: null,
          value: null,
          path: null,
          user_permalink: harry,
          bucket_permalink: animals,
          created_at: null,
          updated_at: null
        }
      }
    """
  
  Scenario: Request a new adjustment with a non-existing bucket
    When I GET "/users/harry/buckets/doesnt-exist/adjustments/300.json"
    Then I should get a 404 Not Found response
    And I should get an empty response body
  
  Scenario: Request a new adjustment with a non-existing user
    When I GET "/users/doesnt-exist/buckets/animals/adjustments/300.json"
    Then I should get a 404 Not Found response
    And I should get an empty response body
  
  Scenario: Request a new adjustment with a non-existing user and bucket
    When I GET "/users/doesnt-exist/buckets/doesnt-exist/adjustments/300.json"
    Then I should get a 404 Not Found response
    And I should get an empty response body
  
  # Scenario: Create an adjustment
  #   Given a typical set of adjustments, buckets, and users
  #   When I POST "/users/harry/buckets/animals/adjustments.json" with body "adjustment[value]=2"
  #   Then I should get a 201 Created response
  #   And pending: I should receive the object in JSON
  
  Scenario: Attempt to create an adjustment with no value
    Given a typical set of adjustments, buckets, and users
    When I POST "/users/harry/buckets/animals/adjustments.json" with body ""
    Then I should get a 422 Unprocessable Entity response
    And I should get a JSON response body like:
    """
      [
        ["value","can't be blank"],
        ["value","is not a number"]
      ]
    """
  
  Scenario: Destroy an adjustment
    Given a typical set of adjustments, buckets, and users
    When I DELETE "/users/harry/buckets/animals/adjustments/104.json"
    Then I should get a 200 OK response
    And I should get a JSON response body like:
    """
      "adjustment": {
        id: 104,
        value: 4,
        path: "/users/harry/buckets/animals/adjustments/104.json",
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
  