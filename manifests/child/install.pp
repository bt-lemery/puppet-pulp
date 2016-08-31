# Pulp Node Install Packages
class pulp::child::install {
  package { [
    'pulp-agent',
    'pulp-nodes-child',
    'pulp-nodes-consumer-extensions']: }
}
