#!/usr/bin/env python

# execute a packer build based off of a YAML config file.

import argparse, json, os, sys, yaml
from cStringIO import StringIO
from glob import glob
from subprocess import Popen, PIPE


CWD = os.path.dirname(os.path.realpath(__file__))

def info(m):
    sys.stderr.write(m + '\n')
    sys.stderr.flush()

def fail(m):
    info(m)
    sys.exit(1)

def parse_args():
    parser = argparse.ArgumentParser(
        prog=sys.argv[0],
        formatter_class=argparse.ArgumentDefaultsHelpFormatter,
        description='Packer build orchestration script')
    parser.add_argument('-d', '--dump', action='store_true',
        help='Dump JSON to file for debugging')
    parser.add_argument('config',
        help='Configuration to build')
    return parser.parse_args()

def main():
    os.chdir(CWD)
    args = parse_args()
    name = args.config
    if not name.endswith('.yaml'):
        fail('Expected a Yaml file')
    info('parsing packer config %r..' % name)
    cfg = yaml.load(open(name, 'rb'))

    try:
        info('converting to json..')
        json_cfg = json.dumps(cfg, indent=2)
    except Exception, e:
        fail(str(e))

    if args.dump:
        try:
            dest = name.replace('.yaml', '.json')
            info('writing json dump file %r' % dest)
            open(dest, 'wb').write(json_cfg)
        except Exception, e:
            fail(str(e))
        sys.exit(0)

    info('synchronizing assets..')
    Popen('./sync_assets', shell=1).communicate()

    info('executing packer..')
    env = os.environ.copy()
    env['PACKER_LOG'] = '1'
    env['PACKER_LOG_PATH'] = 'packer.log'
    cmd = 'packer build -'
    proc = Popen(cmd, shell=1, stdin=PIPE, env=env)
    proc.communicate(input=json_cfg)


if __name__ == '__main__':
    main()

