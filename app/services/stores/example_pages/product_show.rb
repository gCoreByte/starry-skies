# frozen_string_literal: true

module Stores
  module ExamplePages
    class ProductShow < Stores::ExamplePages::Base # rubocop:disable Metrics/ClassLength
      def key
        'product'
      end

      def based_on
        'product'
      end

      def english_content
        <<~HTML
          <!DOCTYPE html>
          <html>
            <head>
              <meta charset="UTF-8">
              <meta name="viewport" content="width=device-width, initial-scale=1.0">
              <title>{{ store.name }}</title>
              <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
            </head>

            <body>
              <div>
              <nav class="navbar navbar-expand-lg bg-body-tertiary ps-3">
              <div class="container-fluid">
                <a class="navbar-brand" href="#">{{ store.name }}</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
                  <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
                  <ul class="navbar-nav">
                    <li class="nav-item">
                      <a class="nav-link" href="/">Home</a>
                    </li>
                    <li class="nav-item">
                      <a class="nav-link" href="/p/products">Products</a>
                    </li>
                    <li class="nav-item dropdown">
                      <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Categories
                      </a>
                      <ul class="dropdown-menu">
                        {% for category in store.product_categories %}
                          <li><a class="dropdown-item" href="/p/category/{{ category.id }}">{{ category.name }}</a></li>
                        {% endfor %}
                      </ul>
                    </li>
                    <li class="nav-item">
                      <a class="nav-link" href="/p/cart">Cart - {{ purchase_cart.item_count }}</a>
                    </li>
                  </ul>
                </div>
              </div>
            </nav>
              </div>
              <div class="row m-3">
                <div class="col-xl-6">
                  <div class="card mb-3 border">
                    <div class="card-header">
                      <h1>{{ product.name }}</h1>
                    </div>
                    <div class="card-body">
                      <p>{{ product.description }}</p>
                      <br>
                      <p>Price: {{ product.price }}</p>
                      <br>
                      <button id="addItem" class="btn btn-primary">Add to Cart</button>
                    </div>
                  </div>
                </div>
              </div>
              <script>
              document.getElementById('addItem').addEventListener('click', function() {
                // URL to which PATCH request will be sent
                var url = '/purchase_carts/add_item';

                // Data to be sent in the PATCH request (if any)
                var data = {
                  item: {
                    key: '{{ product.key }}',
                    quantity: 1
                  }
                };

                // Options for the fetch request
                var options = {
                  method: 'PATCH',
                  headers: {
                    'Content-Type': 'application/json', // Adjust content type as needed
                  },
                  body: JSON.stringify(data),
                };

                // Send the PATCH request
                fetch(url, options)
                  .then(response => {
                    if (response.ok) {
                      console.log('PATCH request successful');
                      window.location.reload();
                      // You can add further actions upon successful response
                    } else {
                      console.error('PATCH request failed');
                      // You can handle error cases here
                    }
                  })
                  .catch(error => {
                    console.error('Error during PATCH request:', error);
                    // You can handle errors here
                  })
              });
              </script>
              <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
            </body>
          </html>
        HTML
      end

      def russian_content
        <<~HTML
          <!DOCTYPE html>
          <html>
            <head>
              <meta charset="UTF-8">
              <meta name="viewport" content="width=device-width, initial-scale=1.0">
              <title>{{ store.name }}</title>
              <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
            </head>

            <body>
              <div>
              <nav class="navbar navbar-expand-lg bg-body-tertiary ps-3">
              <div class="container-fluid">
                <a class="navbar-brand" href="#">{{ store.name }}</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
                  <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
                  <ul class="navbar-nav">
                    <li class="nav-item">
                      <a class="nav-link" href="/">Home</a>
                    </li>
                    <li class="nav-item">
                      <a class="nav-link" href="/p/products">Products</a>
                    </li>
                    <li class="nav-item dropdown">
                      <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Categories
                      </a>
                      <ul class="dropdown-menu">
                        {% for category in store.product_categories %}
                          <li><a class="dropdown-item" href="/p/category/{{ category.id }}">{{ category.name }}</a></li>
                        {% endfor %}
                      </ul>
                    </li>
                    <li class="nav-item">
                      <a class="nav-link" href="/p/cart">Cart - {{ purchase_cart.item_count }}</a>
                    </li>
                  </ul>
                </div>
              </div>
            </nav>
              </div>
              <div class="row m-3">
                <div class="col-xl-6">
                  <div class="card mb-3 border">
                    <div class="card-header">
                      <h1>{{ product.name }}</h1>
                    </div>
                    <div class="card-body">
                      <p>{{ product.description }}</p>
                      <br>
                      <p>Price: {{ product.price }}</p>
                      <br>
                      <button id="addItem" class="btn btn-primary">Add to Cart</button>
                    </div>
                  </div>
                </div>
              </div>
              <script>
              document.getElementById('addItem').addEventListener('click', function() {
                // URL to which PATCH request will be sent
                var url = '/purchase_carts/add_item';

                // Data to be sent in the PATCH request (if any)
                var data = {
                  item: {
                    key: '{{ product.key }}',
                    quantity: 1
                  }
                };

                // Options for the fetch request
                var options = {
                  method: 'PATCH',
                  headers: {
                    'Content-Type': 'application/json', // Adjust content type as needed
                  },
                  body: JSON.stringify(data),
                };

                // Send the PATCH request
                fetch(url, options)
                  .then(response => {
                    if (response.ok) {
                      console.log('PATCH request successful');
                      window.location.reload();
                      // You can add further actions upon successful response
                    } else {
                      console.error('PATCH request failed');
                      // You can handle error cases here
                    }
                  })
                  .catch(error => {
                    console.error('Error during PATCH request:', error);
                    // You can handle errors here
                  });
              });
              </script>
              <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
            </body>

          </html>
        HTML
      end

      def estonian_content
        <<~HTML
          <!DOCTYPE html>
          <html>
            <head>
              <meta charset="UTF-8">
              <meta name="viewport" content="width=device-width, initial-scale=1.0">
              <title>{{ store.name }}</title>
              <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
            </head>

            <body>
              <div>
              <nav class="navbar navbar-expand-lg bg-body-tertiary ps-3">
              <div class="container-fluid">
                <a class="navbar-brand" href="#">{{ store.name }}</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
                  <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNavAltMarkup">
                  <ul class="navbar-nav">
                    <li class="nav-item">
                      <a class="nav-link" href="/">Kodu</a>
                    </li>
                    <li class="nav-item">
                      <a class="nav-link" href="/p/products">Tooted</a>
                    </li>
                    <li class="nav-item dropdown">
                      <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                        Kategooriad
                      </a>
                      <ul class="dropdown-menu">
                        {% for category in store.product_categories %}
                          <li><a class="dropdown-item" href="/p/category/{{ category.id }}">{{ category.name }}</a></li>
                        {% endfor %}
                      </ul>
                    </li>
                    <li class="nav-item">
                      <a class="nav-link" href="/p/cart">Ostukorv - {{ purchase_cart.item_count }}</a>
                    </li>
                  </ul>
                </div>
              </div>
            </nav>
              </div>
              <div class="row m-3">
                <div class="col-xl-6">
                  <div class="card mb-3 border">
                    <div class="card-header">
                      <h1>{{ product.name }}</h1>
                    </div>
                    <div class="card-body">
                      <p>{{ product.description }}</p>
                      <br>
                      <p>Hind: {{ product.price }}</p>
                      <br>
                      <button id="addItem" class="btn btn-primary">Add to Cart</button>
                    </div>
                  </div>
                </div>
              </div>
              <script>
              document.getElementById('addItem').addEventListener('click', function() {
                // URL to which PATCH request will be sent
                var url = '/purchase_carts/add_item';

                // Data to be sent in the PATCH request (if any)
                var data = {
                  item: {
                    key: '{{ product.key }}',
                    quantity: 1
                  }
                };

                // Options for the fetch request
                var options = {
                  method: 'PATCH',
                  headers: {
                    'Content-Type': 'application/json', // Adjust content type as needed
                  },
                  body: JSON.stringify(data),
                };

                // Send the PATCH request
                fetch(url, options)
                  .then(response => {
                    if (response.ok) {
                      console.log('PATCH request successful');
                      window.location.reload();
                      // You can add further actions upon successful response
                    } else {
                      console.error('PATCH request failed');
                      // You can handle error cases here
                    }
                  })
                  .catch(error => {
                    console.error('Error during PATCH request:', error);
                    // You can handle errors here
                  });
              });
              </script>
              <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
            </body>
          </html>
        HTML
      end
    end
  end
end
