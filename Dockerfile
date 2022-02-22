FROM mcr.microsoft.com/powershell:ubuntu-16.04
  
RUN curl -sSL https://github.com/openfaas/faas/releases/download/0.6.15/fwatchdog > /usr/bin/fwatchdog \
    && chmod +x /usr/bin/fwatchdog
WORKDIR /root/

COPY function function

ENV ENV_MAILGUN_API_TOKEN="1234567890"
ENV ENV_MAILGUN_URL="1234567890"
ENV ENV_MAILGUN_FROM="1234567890"

ENV fprocess="pwsh ./function/handler.ps1"

HEALTHCHECK --interval=1s CMD [ -e /tmp/.lock ] || exit 1

CMD ["fwatchdog"]     
