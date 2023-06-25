### Information

Made for training. It allows you to provide a server & deploy a git project inside... That's all :) 

This config is already filled with Scaleway cheapest DEV1-S settings.

Folders are hardcoded with `/home/debian`.

### Environnement

```bash
$ mv variables.yaml.example variables.yaml
```

&

```bash
$ mv env.tf.example env.tf
```

### Dry-run & check

```bash
$ terraform plan --auto-approve
```

### Run

```bash
$ terraform apply --auto-approve
```
