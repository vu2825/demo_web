<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Thanks</title>
    <link rel="stylesheet" href="style.css" />
  </head>
  <body>
    <h1>Thanks for joining!</h1>
    <p>Your info:</p>
    <ul>
      <li>Email: ${user.email}</li>
      <li>First name: ${user.firstName}</li>
      <li>Last name: ${user.lastName}</li>
    </ul>
    <p><a href="index.html">Back</a></p>
  </body>
</html>
