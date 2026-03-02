FROM tomcat:11-jdk17
RUN rm -rf /usr/local/tomcat/webapps/*
COPY target/JEE-Blog.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]
```

---

**2️⃣ بدل `DBConnection.java`** بالكود اللي عطيتك فوق

---

**3️⃣ فـ IntelliJ:**
```
Build → Build Artifacts → JEE-Blog:war → Build