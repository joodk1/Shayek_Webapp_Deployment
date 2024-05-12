# # Use an official Python runtime as a parent image
# FROM python:3.11-slim

# # Set the working directory in the container
# WORKDIR /app

# # Copy the current directory contents into the container at /app
# COPY . /app

# # Install any needed packages specified in requirements.txt
# RUN pip install --no-cache-dir -r requirements.txt

# # Make port 5000 available to the world outside this container
# EXPOSE 5000

# # Define environment variable
# ENV NAME World

# # Run app.py when the container launches
# CMD ["python", "app.py"]
# # Use an official Python runtime as a parent image
# FROM python:3.11-slim

# # Set the working directory in the container
# WORKDIR /app

# # Copy the current directory contents into the container at /app
# COPY . /app
# # Copy the dlib wheel into the container
# COPY dlib-19.24.1-cp311-cp311-win_amd64.whl /tmp/

# # Install the dlib wheel
# RUN pip install /tmp/dlib-19.24.1-cp311-cp311-win_amd64.whl
# # Install any needed packages specified in requirements.txt
# RUN pip install --no-cache-dir -r requirements.txt

# # Make port 5000 available to the world outside this container
# EXPOSE 5000

# # Define environment variable
# ENV NAME World

# # Run app.py when the container launches
# CMD ["python", "main.py"]



# Use an official Python runtime as a parent image
FROM python:3.11-slim

# Set the working directory in the container
WORKDIR /app

# Install system dependencies required for building dlib and other useful tools
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    git \
    libopenblas-dev \
    liblapack-dev \
    libx11-dev \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install\
    libgl1\
    libgl1-mesa-glx \ 
    libglib2.0-0 -y && \
    rm -rf /var/lib/apt/lists/*

# Clone dlib's repository
RUN git clone https://github.com/davisking/dlib.git

# Build dlib from the source
WORKDIR /app/dlib
RUN python3 setup.py install

# Change back to the app directory
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Make port 5000 available to the world outside this container
EXPOSE 5000

# Define environment variable
ENV NAME World

# Run app.py when the container launches
CMD ["python", "main.py"]
