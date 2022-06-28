### [Deployment_Servicios](./deployment_servicios)

  En esta carpeta se encontraran los archivos de deployment correspondientes a cada servicio de la solucion.
  
| Service                                              | Language      | Description                                                                                                                       |
| ---------------------------------------------------- | ------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| [frontend](./src/frontend)                           | Go            | Exposes an HTTP server to serve the website. Does not require signup/login and generates session IDs for all users automatically. |
| [cartservice](./src/cartservice)                     | C#            | Stores the items in the user's shopping cart in Redis and retrieves it.                                                           |
| [productcatalogservice](./src/productcatalogservice) | Go            | Provides the list of products from a JSON file and ability to search products and get individual products.                        |
| [currencyservice](./src/currencyservice)             | Node.js       | Converts one money amount to another currency. Uses real values fetched from European Central Bank. It's the highest QPS service. |
| [paymentservice](./src/paymentservice)               | Node.js       | Charges the given credit card info (mock) with the given amount and returns a transaction ID.                                     |
| [shippingservice](./src/shippingservice)             | Go            | Gives shipping cost estimates based on the shopping cart. Ships items to the given address (mock)                                 |
| [emailservice](./src/emailservice)                   | Python        | Sends users an order confirmation email (mock).                                                                                   |
| [checkoutservice](./src/checkoutservice)             | Go            | Retrieves user cart, prepares order and orchestrates the payment, shipping and the email notification.                            |
| [recommendationservice](./src/recommendationservice) | Python        | Recommends other products based on what's given in the cart.                                                                      |
| [adservice](./src/adservice)                         | Java          | Provides text ads based on given context words.                                                                                   |
| [loadgenerator](./src/loadgenerator)                 | Python/Locust | Continuously sends requests imitating realistic user shopping flows to the frontend.                                              |

[variables.tf](./deployment_servicios/variables.tf)

  * Utilizamos variables para las imagenes creadas en ECR, que luego seran utilizadas en cada deployment.

  * Existe un archivo .tf para cada servicio que requiere nuestra aplicacion web. Cada uno de ellos fue creado en formato terraform a partir de un archivo yaml.
  * En cada uno de estos archivos de deployment, la imagen esta como variable la cual es tomada de nuestro archivo de variables.

[config](./deployment_servicios/config)

  * Este archivo contiene la informacion de nuestro cluster EKS, previamente creado mediante el deploy de nuestra infra. El mismo es necesario para utilizar en el archivo de [provider.tf](./deployment_servicios/provider.tf).
