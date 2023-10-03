FROM ubuntu:20.04

# Update and install necessary packages
RUN apt-get update && apt-get install -y curl

# Download and install temporal
RUN curl -sSf https://temporal.download/cli.sh | sh

# Create a new user and group named 'temporaluser'
RUN groupadd -r temporalgroup && useradd -r -g temporalgroup -m temporaluser

# Change ownership of the necessary directories and files to 'temporaluser'
RUN chown -R temporaluser:temporalgroup /home/temporaluser
RUN cp /root/.temporalio/bin/temporal /bin/temporal && chown temporaluser:temporalgroup /bin/temporal

# Switch to 'temporaluser'
USER temporaluser

CMD ["/bin/bash", "-c", "/bin/temporal server start-dev --ip 0.0.0.0"]
