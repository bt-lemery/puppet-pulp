# Pulp Node Install Packages
class pulp::child::install {
  ensure_packages({ [
    'pulp-agent',
    'pulp-nodes-child',
    'pulp-nodes-consumer-extensions']: })
}
