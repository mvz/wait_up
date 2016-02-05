# Wait Up

Play sound files slowly so you can follow along.

This will be a port of playitslowly to Ruby + GirFFI.

## Usage

Command-line:

    wait_up-cli [file] [tempo]

GUI (just a stub right now):

    wait_up

Press Ctrl-Q to quit.

## Install

    gem install wait_up

## Dependencies

Wait Up needs some additional software installed in order to work.

### Debian

Wait Up needs at least the following:

    sudo apt-get install libgirepository1.0-dev gobject-introspection

More to be determined

### Other OS

To be determined. Please contribute back your experience in getting Wait Up running
on your favorite operation system.

## Contributing

Contributions are welcome! Please feel free to create issues or pull requests
on GitHub.

If you want to run the tests, you may need to install additional packages:

    sudo apt-get install gir1.2-atspi-2.0 libatk-adaptor

## License

Copyright &copy; 2015&ndash;2016 [Matijs van Zuijlen](http://www.matijs.net).
See LICENSE for details.
