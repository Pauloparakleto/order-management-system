# Test-Apply

# Order Management System
Let's build a very simple order management system having orders from pending up to completed state.

## Requirements

- [x] An order has a control number and a state.

- [x] When the order is added to the system, it has a pending state.

- [x] I want to be able to start the progress of an order.

- [x] I want to be able to complete an order.

- [x] I want to filter orders by number control and state.

## Invariants
- [x] A pending order can only go to in progress state.

- [x] An in progress order can only go to completed.

- [x] Completed orders are done and should preserve its state.

## Instructions
Create a github repo to develop your solution.


PS 1: Using a css library/framework is a plus.

PS 2: Tests are needed.

PS 3: We’ll evaluate everything from the git history to the implemented code.

# Start the Project in your own machine

## Clone it

1. Using SSH: `git clone git@github.com:Pauloparakleto/order-management-system.git`


2. Using HTTPS: `git clone https://github.com/Pauloparakleto/order-management-system.git`

## Bundle it

On terminal run: `bundle install`

## PostgreSQL Staff

[I don't have postgre locally on my Ubuntu Machine](https://help.ubuntu.com/community/PostgreSQL). Follow the instruction
on the link and come back to the instructions bellow.

1. Rename the file `database.sample.yml` to `database.yml`
2. Set the password on the default area according to your password, mine is `12345`
3. Set the username on the default area to your role with privilege to create database.
   Mine is the default role. So I comment out the username line in order
   to postgre reach the name of my machine.
4. Start database server: `sudo service postgresql start`

## Connect Rails to the database

Run: `rails db:create db:migrate`

Optionally you might populate the database with initial data: `rails db:seed`.
However, you will not be able to test the create workflow since the delete action is not part of the
current release.

Any way, you may delete the data to restart the create workflow by running:
`rails db:drop db:create db:migrate`

## Run the server
Run: `rails webpacker:install`

Run: `rails server`

## Testing it

At least but also important, run the tests: `rspec`

If your integration test fails with webpack misses configuration warnings, run: `rails webpacker:install`

## Coverage
![Captura de tela de 2021-08-20 10-12-28](https://user-images.githubusercontent.com/52010485/130238967-84720fcb-7e10-4fb1-8567-326f809002a1.png)

