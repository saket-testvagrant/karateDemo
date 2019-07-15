Feature: Karate test script for Users

  Background:
    * url 'http://localhost:3000/'

  Scenario: Get all users
    Given path 'users'
    When method get
    Then status 200
    And match response[0].id == 1

  Scenario: Get single user
    * def id = 2
    Given path 'users', id
    When method get
    Then status 200
    And match response.id == 2

  Scenario: Get all users with pageNo
    * url 'http://reqres.in'
    Given path 'api','users'
    And param page = '3'
    When method get
    Then status 200
    And match response.data[0].id == 7

  Scenario: Verify user not found
    * def invalidUserID = '33'
    Given path 'users', invalidUserID
    When method get
    Then status 404

  Scenario: Create new user
    Given path 'users'
    And request read('classpath:postData.json')
    When method post
    Then status 201
    And match response.first_name == 'Krunal'
    And def newId = response.id
    Given path 'users', newId
    When method get
    Then status 200
    And match response.last_name == 'Gaidhar'
    Given path 'users', newId
    When method delete
    Then status 200
    Given path 'users', newId
    When method get
    Then status 404
    
    

