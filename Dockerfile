# Use an official MySQL image with version 5.7 and above
FROM mysql:5.7

# Set environment variables for MySQL
ENV MYSQL_ROOT_PASSWORD=root
ENV MYSQL_DATABASE=my_database


# Copy the SQL file for creating tables into the container
COPY db/create_tables.sql /docker-entrypoint-initdb.d/create_tables.sql


RUN chown -R mysql:mysql /var/lib/mysql


RUN mysqld --initialize
# Install git and python
RUN yum install -y \
    python3 \
    python-pip

# Clone the project from Git
COPY . /app

# Set working directory to the project root
WORKDIR /app

EXPOSE 3306
# Change directory to the db folder and execute SQL queries
# RUN cd db && \
#     mysql -h 127.0.0.1 -P 3306 -u root -p your_password $MYSQL_DATABASE < create_tables.sql