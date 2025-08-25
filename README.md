# Demo Servlet (Tomcat 10.1, Jakarta Servlet 5)

## Build
```bash
mvn clean package
```

This creates `target/demo.war`.

## Run (Tomcat 10.1)
- Copy `target/demo.war` into Tomcat's `webapps` folder and start Tomcat,
  or use the Tomcat VS Code extension to deploy the war.
- Open: http://localhost:8080/demo/
- The form posts to `/emaillist` and forwards to `thanks.jsp`.
