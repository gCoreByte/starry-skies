## Welcome

Welcome to your newest e-store platform! This is only a proof of concept build with only the bare essentials added. Currently, some features are missing: discounts, campaigns, picture uploads and custom domains. Rest assured, they are being worked on!

## Getting started

Lets get acquainted with the platform. Open the account dashboard by going to `Account Management > Dashboard`. First, create a store. Pick out a name for your store and then a fitting subdomain. For example, a store with the subdomain `my-cool-store` can be accessed at `my-cool-store.corebyte.ee`. To make things easier, it's possible to generate an example store in the options.

## Store overview

Click on the blue eye next to your freshly created store or click on it's name to get to the store overview.
From the store's overview page it's possible to manage every aspect of your new store, from products to web pages. It also provides a quick overview of sales made and revenue generated.

### Attention

Many items require a key to be created. The key is a unique human-readable value to make recognising records easier. Keys are always unique while names are not.

### Categories

To begin, let's create some categories. These can be useful for helping customers sort your various items. Click on the `Categories` button and press the green + button. This will allow you to create your own category. These categories can be added to product versions later.

### Products

Next, lets create some products. Products have versions, which allows you to keep track of previous versions of the same product, e.g. different descriptions, dimensions and so on.
Create a product by clicking the green + button and then adding a key. Open up the newly created product to be able to see it's data and create a product version.

### Product versions

Products only contain the key and keep track of all their versions. To give the product some attributes, prices etc, create a product version.

Product versions contain all the info for a single version of a product. This includes translations for their names and descriptions, their dimensions and various other attributes. All of these attributes are optional - you do not have to add them if you do not want to.
Here you can also add different prices for users. At least one price should have a blank user group if you want everyone to buy it! User groups will be explained further on. You can also add categories to a product here.
On the left in the details window, there is a blue button with a page on it. Here you can add translations for the product.
Once the product has a price, it can be activated from the green play button. Once activated, it will be included in the store.

### Orders

Here you have an overview of all the placed orders. Orders can have 5 different statuses: `created`, `processing`, `in_transit`, `completed` and `failed`.
A short explanation of the statuses:

- `created` - A customer has placed an order and it is awaiting confirmation.
- `processing` - Their order has been accepted and is waiting to be shipped.
- `in_transit` - Their order has been shipped.
- `completed` - The order has arrived to the customer.
- `failed` - Something has gone wrong and the order could not be completed. This can happen for various reasons - the user cancelled their order, something was out of stock etc.
Currently, you should have no orders as nobody has bought anything yet.

### User accounts

In this view you can find an overview of all the accounts created on your store. It's possible to add groups to the various accounts here. These groups will later have different prices in your store.

### User groups

Here you can create different user groups. The higher the ranking, the higher its priority is. For example, when a user has 2 different groups `loyal` with a ranking of 1 and `great` with a ranking of 2, the user will see the prices of `loyal` groups first, then prices of `great` groups if applicable and only then will they see the global price.

### Page templates

This is the most difficult part of the guide to understand but also the most important. Using page templates, you can create your own pages. A page template has a key and a based on value. The based on value dictates what sort of record the page will expect.

Upon creating a page template, you must now create the translations. Currently, there are 3 different locales: `en`, `et` and `ru`. The content for each translation is the HTML code that will be rendered. To make your pages dynamic, you can use Liquid variables inside your HTML code. To see what variables are available for each based on record, see the Variables documentation page.

#### Liquid variables

Liquid variables can be accessed with `{{ record.variable }}`. When generated, these will be replaced with the value. Liquid can also be used for more complex actions, such as loops and conditionals. For a complete documentation of Liquid, see their official documentation at <https://github.com/Shopify/liquid/wiki/Liquid-for-Designers>.

Once you have created the page template, make sure to activate it from the green play button. This will ensure you can use this template in your pages.

### Pages

Here you can create your web page. Give it a key to identify it, a unique URL and select a page template to use. The page is not accessible until you make it live by pressing the green play button.

The page will be accessible at the following url: `/p/<page_url>/<record_id>`, where `page_url` is the URL selected for the page and `record_id` is the ID of a record that has the same type as the templates `based_on`. It's important to note that page templates with a `based_on` value of `store`,`purchase_cart` or `user_account` do not need a `record_id` - they can be accessed with only `/p/<user_id>`.

Locales are set by a cookie - `locale`. This cookie will default to `en`, but can be set to `et` or `ru` to access the other languages.

### API usage

An API in this context is a web URL that is accessed to do some sort of action. From a browser, these are almost always accessed through the use of Javascript. Don't worry! They are very simple to use and an example is also provided below.

Some parts of the store require the usage of an API, such as adding and removing items from a users cart. These can be accessed by using Javascript. An example button will be provided below.

Currently, there are only 2 API endpoints:

- `purchase_carts/add_item`
- `purchase_carts/remove_item`
Both use the PATCH HTTP method and take their input in the following JSON format:

```
item: {
 key: 'product_key_here',
 quantity: quantity_here
}
```

For example, to create a button that adds a product to the cart, you could use the following code on a product-based page:

```javascript

// This is the button that the user sees
<button id="addItem">Add to Cart</button>
<script>
 // Find the button by its id (addItem) and do something when it's clicked
 document.getElementById('addItem').addEventListener('click', function() {

  // the url of our endpoint
  var url = '/purchase_carts/add_item';
  // the data we will send
  var data = {
   item: {
    key: '{{ product.key }}', // the product key
    quantity: 1
   }
  };
  var options = {
   method: 'PATCH', // all the APIs receive PATCH
   headers: {
    'Content-Type': 'application/json', // the api consumes json
   },
   body: JSON.stringify(data),
  };
  // Send the PATCH request
  fetch(url, options).then(response => {
   if (response.ok) {
    // reload the window to update the purchase cart count
    window.location.reload();
   } else {
    console.error('PATCH request failed');
    // The server returned an error, eg item doesnt exist
   }
  }).catch(error => {
   console.error('Error during PATCH request:', error);
   // Something went wrong while sending the request, such as badly formatted data.
  });
 });
</script>
```

### Completing a purchase order

To finalise a purchase, redirect the user to `/purchase_orders/new`. On this page, they will be able to complete their purchases as well as pay in the future. It will be possible to edit this page in the future.

### Creating accounts and logging in

To create a user account, the user must go to `/user_accounts/new`, where they can register. To log in, the user must go to `/user_sessions/new`. To log out, send a HTTP delete request to `/user_sessions/`.
