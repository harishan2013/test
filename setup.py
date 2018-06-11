"""A setuptools based setup module.tn.going to merge.newbr

See:
https://packaging.python.org/en/latest/distributing.html
"""

# Always prefer setuptools over distutils
from setuptools import setup, find_packages
# To use a consistent encoding

#Will install the packages along with Project package Installation
with open('requirements.txt', 'r') as f:
    INSTALL_REQUIRES = [x for x in list(f)]

setup(
    name='MIGDataCollector',

    # Versions should comply with PEP440.  For a discussion on single-sourcing
    # the version across setup.py and the project code, see
    # https://packaging.python.org/en/latest/single_source_version.html
    version='1.2.18',

    classifiers=[
        # How mature is this project? Common values are
        #   3 - Alpha.
        #   4 - Beta..
        #   5 - Production/Stable.
        'Development Status :: 3 - Alpha',

        # Indicate who your project is intended for
        'Intended Audience :: Developers',
        'Topic :: MIGATEWAY Development :: Build Tools',

        # Specify the Python versions you support here. In particular, ensure
        # that you indicate whether you support Python 2, Python 3 or both.
        'Programming Language :: Python :: 2',
        'Programming Language :: Python :: 2.6',
        'Programming Language :: Python :: 2.7',
        'Programming Language :: Python :: 3',
        'Programming Language :: Python :: 3.3',
        'Programming Language :: Python :: 3.4',
        'Programming Language :: Python :: 3.5',
    ],

    # You can just specify the packages manually here
    packages=find_packages(exclude=["*.tests"]),
    # If there are data/txt files included in your packages that need to be specify here
    include_package_data=True,
    install_requires=INSTALL_REQUIRES,
    package_data={        
        'MIGDataCollector': ['*'],        
         '':['*','*.txt'],
    },

    # To provide executable scripts, use entry points in preference to the
    # "scripts" keyword. Entry points provide cross-platform support and allow
    # pip to create the appropriate form of executable for the target platform.
    entry_points={
        'console_scripts': [
            'MIGDataCollector=MIGDataCollector:main',
        ],
    },
)
