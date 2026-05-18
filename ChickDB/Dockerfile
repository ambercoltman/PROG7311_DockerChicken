#Use the microsoft SQL Server image as the base
FROM mcr.microsoft.com/mssql/server:2022-latest

#set environment variables required for SQL Server
    ENV ACCEPT_EULA=Y
    ENV MSSQL_PID=Express
    ENV MSQL_SA_PASSWORD=Password1!

#switch to root for directory creation and additional setups
USER root
RUN mkdir -p /app/init-scripts && chown mssql /app/init-scripts

#copy the initialization script to the container
COPY ./ChickDB/init-database.sql /app/init-scripts/

#install necessary tools
ENV PATH="$PATH:/opt/mssql-tools18/bin"

#revert to default SQL Server user for security
USER mssql

#healthcheck using the updated tools path and -C (trust server certificate)
HEALTHCHECK --interval=10s --timeout=5s --start-period=30s --retries=5 \
    CMD /opt/mssql-local/bin/sqlcmd -S localhost -U sa -P "$MSSQL_SA_PASSWORD" -C -Q "SELECT 1" || exit 1

#start SQL Server and run the init script
#added -C to sqlcmd to handle SSL certificate trust in newer images
CMD /bin/bash -c "/opt/mssql/bin/sqlservr & \
    sleep 25 && \
    if /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P '$MSSQL_SA_PASSWORD' -C -Q 'SELECT name FROM sys.databases WHERE name = \"Farm\"' | grep -q Farm; then \
        echo 'Database already exists'; \
    else \
        echo 'Initializing database'; \
        /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P '$MSSQL_SA_PASSWORD' -C -d master -i /app/init-scripts/init-database.sql; \
    fi && wait"  