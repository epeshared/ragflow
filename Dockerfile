FROM infiniflow/ragflow-base:v2.0
USER  root

WORKDIR /ragflow

ADD ./web ./web
RUN npm config set proxy http://child-prc.intel.com:913
RUN npm config set https-proxy http://child-prc.intel.com:913
# RUN npm config set registry https://registry.npmmirror.com/ 
# RUN npm config set fetch-timeout 600 && npm config set connect-timeout 600
RUN cd ./web && npm i --force && npm run build

ADD ./api ./api
ADD ./conf ./conf
ADD ./deepdoc ./deepdoc
ADD ./rag ./rag
ADD ./agent ./agent

ENV PYTHONPATH=/ragflow/
ENV HF_ENDPOINT=https://hf-mirror.com

ADD docker/entrypoint.sh ./entrypoint.sh
ADD docker/.env ./
RUN chmod +x ./entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]
