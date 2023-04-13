# Wishlist

This repository contains a Ruby on Rails application capable of creating client and a wishlist for a e-commerce

In this application you can:

- Create/Update/Delete/Read Clients
- Create one Wishlists for the Client

## How to run:

- Clone the repository
- Then run ```rails s ``` 

The server should be running on your ```localhost``` port ```3000```

Since we are using e-mail confirmation, when client is created. You should create a ```.env``` file on the root of this project. You can use this as an exemple.

```
export MAIL_DEVELOPMENT_URL=localhost
export MAIL_DEVELOPMENT_PORT=1025
```


## Tests

This application is 100% test covered with ```Rspec``` gem.

You just need to run ```bundle exec rspec```

## Lint

This project is also covered by ```rubocop```

You just need to run ```rubocop```on terminal


## How to use

Create client:




