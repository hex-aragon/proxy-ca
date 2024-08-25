// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "src/TodoList.sol";
import "forge-std/console.sol"; 

contract TodoListTest is Test {

    TodoList public todoList;

    function setUp() public {
 
        todoList = new TodoList();
    }

    function test_createTodo_returnsNumberOfTodosIncrementedByOne() public {

        uint256 numberOfTodosBefore = todoList.getNumberOfTodos();
        console.log("numberOfTodosBefore %s",numberOfTodosBefore );


        uint256 numberOfTodosAfter = todoList.createTodo("A new todo for you!");
        console.log("numberOfTodosAfter %s",numberOfTodosAfter );
        assertEq(numberOfTodosAfter, (numberOfTodosBefore + 1), "create todo test");

        uint256 numberOfTodosAfter2 = todoList.createTodo("A new todo for you!2222");
        console.log("numberOfTodosAfter2 %s",numberOfTodosAfter2 );
        assertEq(numberOfTodosAfter2, (numberOfTodosBefore + 2), "create todo test22");

    }

}