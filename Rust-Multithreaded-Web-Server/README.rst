###############################################################################################################
`Building a Multithreaded Web Server <https://doc.rust-lang.org/book/ch20-00-final-project-a-web-server.html>`_
###############################################################################################################

`Alexander L. Hayes <https://hayesall.com>`_

Run the server
==============

Dependencies and building are handled through Cargo.

.. code-block:: bash

    $ cargo check

A demo script ``run.sh`` is included. It will compile a release build, start the server, and open up several
windows in Firefox.

.. code-block:: bash

    ./run.sh

Outline
=======

Here is the plan to build the web server:

1. Learn a bit about TCP and HTTP.
2. Listen for TCP connections on a socket.
3. Parse a small number of HTTP requests.
4. Create a proper HTTP response.
5. Improve the throughput of our server with a thread pool.

Module References
=================

- ``std::net``: (`Documentation <https://doc.rust-lang.org/std/net/>`_) Networking primitives for TCP/UDP connections.
- ``std::sync``: (`Documentation <https://doc.rust-lang.org/std/sync/>`_) Useful synchronization primitives.
