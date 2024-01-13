# E-Commerce API

This repository contains a Ruby on Rails application capable of creating client and a wishlist for a e-commerce

In this application you can:

- Create/Read/Update/Delete Users
- Create/Read/Update/Delete Wishlist
- Create/Read/Update/Delete Products
- Create one Wishlists for Client

# What you will need to run this project.
- docker

## How to run:

- clone the repository.
- ```sudo docker-compose up --build```.

The server should be running on your ```localhost``` port ```3000```

We are using .env for all variables.

```
export MAIL_DEVELOPMENT_URL=localhost
export MAIL_DEVELOPMENT_PORT=1025
```

## Tests

This application is 100% test covered with ```Rspec``` gem.

You just need to run ```sudo docker-compose run web bundle exec rspec```

## Lint

This project is also covered by ```rubocop```

You just need to run ```sudo docker-compose run web bundle exec rubocop```.

## How to use

Create client:

```{"client": {"name": "michel", "email": "rails.michel@gmail.com", "password": "1234567890"}}```

Delete client:
```http://127.0.0.1:3000/clients/{id}```

Get all clients:
```http://127.0.0.1:3000/clients/```

Get a client:
```http://127.0.0.1:3000/clients/{id}```


Create Wishlist:

```{ "wishlist": { "client_id": 1, "products": 1 } }```

Delete wishlist:
```http://127.0.0.1:3000/wishlists/{id}```

Get all wishlists:
```http://127.0.0.1:3000/wishlists/```

Get a wishlist:
```http://127.0.0.1:3000/wishlists/{id}```


Create product:

```{"product": {"name": "iphone", "image": "iphone.png", "url": ""}}```

ps: You should leave the url field empty, it will be overriten for the bucket url.

Delete product:
```http://127.0.0.1:3000/products/{id}```

Get all products:
```http://127.0.0.1:3000/products/```

Get a product:
```http://127.0.0.1:3000/wishlists/{id}```

# TODO:

1. make byebug work (done)
1. make the images downloadables (done) -> issue was being caused by the ACL not being public.
1. load the images url to my database (done)
1. review all the tests cases (in progress)
1. review the docker-compose and dockerfile
