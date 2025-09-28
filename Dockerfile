FROM squidfunk/mkdocs-material:latest

RUN pip install --no-cache-dir \
    mike \
    mkdocs-minify-plugin \
    pymdown-extensions \
    mkdocstrings[python] \
    mkdocs-mermaid2-plugin

WORKDIR /docs

EXPOSE 8000

CMD ["serve", "-a", "0.0.0.0:8000"]
