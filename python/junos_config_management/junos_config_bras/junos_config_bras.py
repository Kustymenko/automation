#!/usr/bin/python

__version__ = "1.0"

import yaml

from jnpr.junos import Device
from jnpr.junos.utils.config import Config


node = Device(host="198.51.100.1", ssh_private_key_file="")
node.open()
cfg = Config(node)
cfg.rollback()
readfile = open('/root/junos_bras_config/junos_config_bras.yml').read()
cfgvars = yaml.safe_load(readfile)
cfg.load(template_path='/root/junos_bras_config/template_junos_config_bras.j2', template_vars=cfgvars, format='set')
cfg.pdiff()
cfg.commit()
# cfg.rollback()
