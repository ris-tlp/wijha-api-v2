FROM amazon/aws-lambda-python:3.9.2022.09.08.17
# FROM amazon/aws-lambda-python:3.8

ARG FUNCTION_DIR="/var/task/"

COPY ./ ${FUNCTION_DIR}

# Dependencies
RUN pip install --upgrade pip
RUN pip install pipenv
RUN pipenv requirements > requirements.txt
RUN pip install --user --upgrade -r requirements.txt

# Grab the zappa handler.py and put it in the working directory
RUN ZAPPA_HANDLER_PATH=$( \
    python -c "from zappa import handler; print (handler.__file__)" \
    ) \
    && echo $ZAPPA_HANDLER_PATH \
    && cp $ZAPPA_HANDLER_PATH ${FUNCTION_DIR}


CMD [ "handler.lambda_handler" ]
