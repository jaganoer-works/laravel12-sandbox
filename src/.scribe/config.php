<?php

use Knuckles\Scribe\Extracting\Strategies;

return [
    'theme' => 'default',

    'title' => 'Laravel 12 Sandbox API Documentation',

    'description' => 'API documentation for Laravel 12 Sandbox project',

    'base_url' => 'http://localhost:8080',

    'routes' => [
        [
            'match' => [
                'prefixes' => ['api/*'],
                'domains' => ['*'],
            ],
            'include' => [],
            'exclude' => [],
        ],
    ],

    'type' => 'static',
    'static' => [
        'output_path' => 'public/docs',
    ],

    'try_it_out' => [
        'enabled' => true,
        'base_url' => null,
    ],

    'examples' => [
        'faker_seed' => null,
        'models_source' => ['factoryCreate', 'factoryMake', 'databaseFirst'],
    ],

    'auth' => [
        'enabled' => true,
        'default' => false,
        'in' => 'bearer',
        'name' => 'token',
        'use_value' => env('SCRIBE_AUTH_KEY'),
        'placeholder' => '{YOUR_AUTH_KEY}',
        'extra_info' => 'You can retrieve your token by logging in to the application.',
    ],

    'groups' => [],
    'logo' => false,
    'last_updated' => 'Last updated: {date}',
    'examples' => true,
]; 