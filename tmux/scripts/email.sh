#!/bin/bash

# Define your IMAP server and credentials
source ~/develop/dotfiles-auto/secrets.txt

# Define the mailbox you want to check
MAILBOX="INBOX"

# Use Python to connect to the IMAP server and check for unread emails
python3 - <<EOF
import imaplib

# Connect to the IMAP server
imap = imaplib.IMAP4_SSL("$IMAP_SERVER", $IMAP_PORT)
imap.login("$IMAP_USER", "$IMAP_PASSWORD")


# Select the mailbox
mailbox_name = "$MAILBOX"
response, data = imap.select(mailbox_name)
print(f"Server Response: {response}")
if response == "OK":
    # Get the number of unread emails
    _, message_data = imap.search(None, "(UNSEEN)")
    unread_email_ids = message_data[0].split()
    unread_count = len(unread_email_ids)
    if unread_count > 10:
        print(f"∞")
    elif unread_count < 1:
        print(f"")
    else:
        print(f"")


else:
    print(f"Failed to select mailbox {mailbox_name}.")

# Close the IMAP connection
imap.logout()
EOF
