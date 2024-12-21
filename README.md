# Mortgage Backend

This project is a backend API for managing mortgage data. It implements a multi-step form for capturing mortgage information with validation rules and handles storing this data in a relational database. The API supports features like action types (Buy, Refinance), property types, loan details, and user-specific inputs.

## Features

- Multi-step form submission for mortgage details
- Validation of mortgage data at each step
- Enum-based attributes for various fields
- Calculations for monthly payments

## Installation

1. Clone the repository:
   git clone <https://github.com/CheleaMihail/mortgage_backend.git>
2. Install dependencies:
   bundle install
3. Set up the database:
   rails db:create db:migrate

## Usage

- Run the server:
rails server
Access the API at <http://localhost:3000>.
