import resend

resend.api_key = "re_FKJ2ePkb_JxmYSjgULW689QiFXWfsXmXZ"

r = resend.Emails.send({
  "from": "onboarding@resend.dev",
  "to": "meinspaulo@gmail.com",
  "subject": "Hello World",
  "html": "<p>Congrats on sending your <strong>first email</strong>!</p>"
})
