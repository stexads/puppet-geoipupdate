Facter.add('geoipupdate_version') do
  setcode do
    version = nil






# Following check for installable versions, but does not check if the package is already installed.
#    if Facter::Core::Execution.which('rpm')
#      # RPM-based systems
#      #version = Facter::Core::Execution.execute('rpm -q --qf "%{VERSION}" geoipupdate 2>/dev/null').strip
#      version = Facter::Core::Execution.execute('dnf --q list available geoipupdate | awk \'NR>1 {print $2}\' | sort -V | tail -1').strip
#    elsif Facter::Core::Execution.which('dpkg-query')
#      # Debian-based systems
#      version = Facter::Core::Execution.execute('apt-cache policy geoipupdate | awk \'/Candidate:/ {print $2}\' 2>/dev/null').strip
#    else
#      version = 'Unsupported system/package manager'
#    end

    version.empty? ? nil : version
  end
end
