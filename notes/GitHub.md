## Generating a new SSH key and adding it to the ssh-agent
```
$ ssh-keygen -t ed25519 -C "your_email@example.com"
$ cat .ssh/id_ed25519.pub
```

### Add key to GitHub
Go to settings --> SSH and GPG keys adn click New SSH key add name and your key.
