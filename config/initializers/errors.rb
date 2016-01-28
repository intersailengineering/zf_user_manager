# Smtp
require 'net/smtp'

SMTP_SERVER_ERRORS = [
    IOError,
    Net::SMTPAuthenticationError,
    Net::SMTPServerBusy,
    Net::SMTPUnknownError,
    Net::SMTPUnsupportedCommand,
    TimeoutError,
]

SMTP_CLIENT_ERRORS = [Net::SMTPFatalError, Net::SMTPSyntaxError, ActionView::Template::Error]

SMTP_ERRORS = SMTP_SERVER_ERRORS.concat(SMTP_CLIENT_ERRORS)

