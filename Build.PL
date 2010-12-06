
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  'build_requires' => {
    'Locale::Msgfmt' => '0.15',
    'Module::Build' => '0.3601',
    'Test::More' => '0'
  },
  'configure_requires' => {
    'Module::Build' => '0.3601'
  },
  'dist_abstract' => 'Catalyst helper interface for Padre',
  'dist_author' => [
    'Breno G. de Oliveira <garu@cpan.org>',
    'Ahmad M. Zawawi <ahmad.zawawi@gmail.com>'
  ],
  'dist_name' => 'Padre-Plugin-Catalyst',
  'dist_version' => '0.11',
  'license' => 'perl',
  'module_name' => 'Padre::Plugin::Catalyst',
  'recommends' => {},
  'recursive_test_files' => 1,
  'requires' => {
    'Catalyst::Devel' => '1.0',
    'Catalyst::Runtime' => '5.70',
    'File::Which' => '0.05',
    'Padre' => '0.57'
  },
  'script_files' => [],
  'share_dir' => {
    'dist' => 'share'
  }
);


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
