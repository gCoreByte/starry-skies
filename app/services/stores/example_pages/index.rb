# frozen_string_literal: true

module Stores
  module ExamplePages
    class Index < Stores::ExamplePages::Base # rubocop:disable Metrics/ClassLength
      def key
        'index'
      end

      def based_on
        'store'
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
              <style>
                .container {
                  max-width: 800px;
                  margin: 0 auto;
                  padding: 20px;
                  text-align: center;
                }

                h1 {
                  color: #333;
                }

                p {
                  color: #666;
                  margin-bottom: 20px;
                }

                .btn {
                  display: inline-block;
                  padding: 10px 20px;
                  background-color: #007bff;
                  color: #fff;
                  text-decoration: none;
                  border-radius: 5px;
                }

                .btn:hover {
                  background-color: #0056b3;
                }
              </style>
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
                  </ul>
                </div>
              </div>
            </nav>
              </div>
              <div class="container">
                <h1>Welcome to {{ store.name }}</h1>
                <p>Discover amazing products at great prices!</p>
                <a href="p/products" class="btn">Shop Now</a>
              </div>
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
              <style>
                .container {
                  max-width: 800px;
                  margin: 0 auto;
                  padding: 20px;
                  text-align: center;
                }

                h1 {
                  color: #333;
                }

                p {
                  color: #666;
                  margin-bottom: 20px;
                }

                .btn {
                  display: inline-block;
                  padding: 10px 20px;
                  background-color: #007bff;
                  color: #fff;
                  text-decoration: none;
                  border-radius: 5px;
                }

                .btn:hover {
                  background-color: #0056b3;
                }
              </style>
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
                </ul>
              </div>
            </div>
          </nav>
            </div>
              <div class="container">
                <h1>Tere tulemast {{ store.name }}</h1>
                <p>Avasta imelisi tooteid heade hindadega!</p>
                <a href="p/products" class="btn btn-primary">Ostle nüüd</a>
              </div>
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
              <style>
                .container {
                  max-width: 800px;
                  margin: 0 auto;
                  padding: 20px;
                  text-align: center;
                }

                h1 {
                  color: #333;
                }

                p {
                  color: #666;
                  margin-bottom: 20px;
                }

                .btn {
                  display: inline-block;
                  padding: 10px 20px;
                  background-color: #007bff;
                  color: #fff;
                  text-decoration: none;
                  border-radius: 5px;
                }

                .btn:hover {
                  background-color: #0056b3;
                }
              </style>
              <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
                integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
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
                  </ul>
                </div>
              </div>
            </nav>
              </div>
              <div class="container">
                <h1>(ru) Welcome to {{ store.name }}</h1>
                <p>Discover amazing products at great prices!</p>
                <a href="p/products" class="btn">Shop Now</a>
              </div>
              <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz"
                crossorigin="anonymous"></script>
            </body>

          </html>
        HTML
      end
    end
  end
end
