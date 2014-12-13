def FlagsForFile(filename, **kwargs):
    flags = [
        '-Wall',
        '-Wextra',
        '-Werror',
        '-pedantic'
    ]
    data = kwargs['client_data']
    filetype = data['&filetype']
    if filetype == 'c':
        flags += ['ansi']
    elif filetype == 'cpp':
        flags += ['-std=c++11']
        flags += ['stdlib=libc++']
    return {
        'flags': flags,
        'do_cache': True
    }
