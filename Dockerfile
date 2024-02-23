# Using the latest version of a basic lightweight Alpine OS
FROM alpine:latest

# Install python3 and py3-pip
RUN apk add --no-cache python3 py3-pip

# No need to install virtualenv separately as we can use Python's built-in venv

# Create a virtual environment using Python's built-in venv
RUN python3 -m venv /app/venv

# Activate the virtual environment for subsequent commands
ENV PATH="/app/venv/bin:$PATH"

# Now that we're using the virtual environment, we can safely upgrade pip
# and install other packages without affecting the system-wide Python installation
RUN pip install --no-cache-dir --upgrade pip

# Copy requirements.txt to /tmp/
COPY ./requirements.txt /tmp/

# Install the dependencies in the requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

# Make a directory where the code will be copied
RUN mkdir /cqp4rdf

# Copy the code present in ./cqp4rdf to /cqp4rdf/cqp4rdf of the container
COPY ./cqp4rdf /cqp4rdf/cqp4rdf

# Copy the grammar file to /cqp4rdf of the container
COPY ./cqp.ebnf /cqp4rdf

# Shift the working directory to /cqp4rdf/cqp4rdf/
WORKDIR /cqp4rdf/cqp4rdf/

# Expose the port on which the app will be working
EXPOSE 8088

# The command to run when entering the container, i.e., the ENTRYPOINT
ENTRYPOINT ["python3"]

# The filename to follow the ENTRYPOINT, so the app is running
CMD ["main.py"]
