module BankSim

export Bank, Customer, defaultBank, defaultCustomer, deposit, withdraw

mutable struct Bank

    name::String
    cash::Float64
    totalCredit::Float64
    totalDeposit::Float64
    equity::Float64

    #An inner constructor
    Bank(name) = new(name, 1000.0, 10.0, 10.0, 1000.0)
end

function defaultBank(bank::Bank)
    bank.name = "DEFAULT-"*bank.name
    bank.cash = bank.equity = bank.totalCredit = bank.totalDeposit = 0;
end


mutable struct Customer
    name::String
    cash::Float64
    bankDeposit::Float64

    Customer(name) = new(name, 50.0, 0.0)
end

function defaultCustomer(customer::Customer)
    customer.name = "DEFAULT"*customer.name
    customer.bankDeposit = 0.0
    customer.cash = 0.0
end

function deposit(customer::Customer, bank::Bank, amount::Float64)

    if customer.cash >= amount
        customer.cash -= amount
        customer.bankDeposit += amount

        bank.cash += amount
        bank.totalDeposit += amount
    else
        println("Not enough cash to deposit this amount!.")
    end
end


function withdraw(bank::Bank, customer::Customer, amount::Float64)

    if bank.cash >= amount # bank should have enough cash
        if customer.deposit >= amount # customer's account should have enough deposit
            bank.cash -= amount
            bank.totalDeposit -= amount
            customer.cash += amount
            customer.bankDeposit -= amount
        else
            println("Sorry! You don't have that amount in your deposit account!")
        end
    else
        println("Sorry! Not enough cash in bank vault at the moment!")
    end
end

end # End of Module
