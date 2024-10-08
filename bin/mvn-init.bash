#!/bin/bash
# shellcheck disable=SC2181

if [ "$#" -ne 1 ]; then
    echo "ERROR: Provide app name"
    echo 'For example: mvn-init.bash my-new-app'
    exit 1
fi

# maven-archetype-archetype	    An archetype to generate a sample archetype project.
# maven-archetype-j2ee-simple	  An archetype to generate a simplifed sample J2EE application.
# maven-archetype-mojo	        An archetype to generate a sample a sample Maven plugin.
# maven-archetype-plugin	      An archetype to generate a sample Maven plugin.
# maven-archetype-plugin-site	  An archetype to generate a sample Maven plugin site.
# maven-archetype-portlet	      An archetype to generate a sample JSR-268 Portlet.
# maven-archetype-quickstart	  An archetype to generate a sample Maven project.
# maven-archetype-simple	      An archetype to generate a simple Maven project.
# maven-archetype-site	        An archetype to generate a sample Maven site
#                               which demonstrates some of the supported document types
#                               like APT, XDoc, and FML and demonstrates how to i18n your site.
# maven-archetype-site-simple	  An archetype to generate a sample Maven site.
# maven-archetype-webapp	      An archetype to generate a sample Maven Webapp project.
mvn archetype:generate \
    -DgroupId=net.friendlyrobot.${1} \
    -DartifactId=${1} \
    -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false
