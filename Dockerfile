FROM python:3.10.12 as base

# COPY requirements/dev.txt requirements-dev.txt
COPY requirements/base.txt requirements-base.txt
RUN python3 -m pip install -r requirements-base.txt

RUN python3.10 -c "import nltk; nltk.download('punkt')" && \
  python3.10 -c "import nltk; nltk.download('averaged_perceptron_tagger')" && \
  python3.10 -c "from unstructured.partition.model_init import initialize; initialize()"

RUN apt install tesseract-ocr
FROM model-deps as code
COPY prepline_general/ prepline_general/

CMD [ "prepline_general.api.app.handler" ]