FROM squidfunk/mkdocs-material

WORKDIR /docs

COPY requirements.txt .

RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt
