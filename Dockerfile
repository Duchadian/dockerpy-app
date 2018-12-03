FROM continuumio/miniconda3:latest

# Install extra packages if required
RUN apt-get update && apt-get install -y \
    xxxxxx \
    && rm -rf /var/lib/apt/lists/*

# Add the user that will run the app (no need to run as root)
RUN groupadd -r myuser && useradd -r -g myuser myuser

WORKDIR /app

# Install myapp requirements
COPY environment.yml /app/environment.yml
RUN conda config --add channels conda-forge \
    && conda env create -n myapp -f environment.yml \
    && rm -rf /opt/conda/pkgs/*

# Install myapp
COPY . /app/
RUN chown -R myuser:myuser /app/*

# activate the myapp environment
ENV PATH /opt/conda/envs/myapp/bin:$PATH
