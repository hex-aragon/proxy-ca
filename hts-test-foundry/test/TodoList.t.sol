// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "src/TodoList.sol";
import "forge-std/console.sol"; 

contract TodoListTest is Test {
    // Step 1: Create your test instance
     /* ... */
    TodoList public todoList;

    // The setup() function is invoked before each test case is run
    function setUp() public {
        // Step 2: Deploy a new contract everytime you run a test
        /* ... */
        todoList = new TodoList();
    }

    function test_createTodo_returnsNumberOfTodosIncrementedByOne() public {
        // get the current number of todos
        uint256 numberOfTodosBefore = todoList.getNumberOfTodos();
        console.log("numberOfTodosBefore %s",numberOfTodosBefore );

        // create a new todo and save the number of todos
        uint256 numberOfTodosAfter = todoList.createTodo("A new todo for you!");
        console.log("numberOfTodosAfter %s",numberOfTodosAfter );
        assertEq(numberOfTodosAfter, (numberOfTodosBefore + 1), "create todo test");

        uint256 numberOfTodosAfter2 = todoList.createTodo("A new todo for you!2222");
        console.log("numberOfTodosAfter2 %s",numberOfTodosAfter2 );
        assertEq(numberOfTodosAfter2, (numberOfTodosBefore + 2), "create todo test22");

        // Step 3: Confirm that the number of todos increases by one
        /* ... */
    }

}