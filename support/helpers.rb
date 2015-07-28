def copy_bin_scripts
  put_heading "Copy some useful bin scripts"
  Dir[File.join(PATH, "binscripts/*")].each do |source|
    filename = File.basename(source)
    dest = "/usr/local/bin/#{filename}"
    if File.exists? dest
      puts "There is already a copy of #{filename}. Overwrite? (y/N)"
      unless %w[y Y].include? gets.chomp
        puts " >> Ignoring #{filename}"
        next
      end
      move_to_trash(dest)
    end

    FileUtils.cp(source, dest)
    `chmod +x #{dest}`
  end
end

def get_home_directory
  pathmatch = PATH.match(/^(\/Users\/[^\/]*)\//)
  raise "This git repo must be under your home directory!" unless pathmatch
  pathmatch[1]
end

def install_homebrew_formulas
  raise "Homebrew must be installed" if `which brew` == ''
  put_heading "Installing and upgrading Homebrew formulas"
  puts `brew update`
  puts `brew upgrade --all`
  puts `brew cleanup`
  BREW_FORMULAS.each do |formula|
    puts `brew install #{formula}`
  end
end

def install_vim
  put_heading "Trashing old .vim directory and installing vundle in a new one"
  move_to_trash File.join(HOME, '.vim')
  FileUtils.mkdir "#{HOME}/.vim"
  FileUtils.mkdir "#{HOME}/.vim/bundle"
  `git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle`
end

def move_to_trash(object)
  trash_to = File.join(TRASH, File.basename(object))
  if File.exists?(object) && File.symlink?(object)
    target = File.readlink(object)
    return if block_given? && yield(target)
    FileUtils.mv(target, trash_to) if File.exists?(target)
  elsif File.exists?(object)
    FileUtils.mv(object, trash_to)
  end
  FileUtils.rm_f(object) # delete file, symlink or dead symlink
end

def notify_todos(*strings)
  puts "\n\n#{'='*80}\n=#{' '*37}TO DO#{' '*36}=\n#{'='*80}\n\n"
  strings.each { |str| puts "  * #{str}" }
  puts "\n\n"
end

def put_heading(str)
  puts "\n#{str}\n#{'-'*str.length}\n"
end

def run_script(filename, desc)
  put_heading desc
  puts `./scripts/#{filename}.sh`
end

def symlink_dotfiles
  put_heading "Symlinking config files (deleting old ones!)"
  DOTFILES.each do |dotfile|
    source = File.join(PATH, "dotfiles", dotfile)
    dest = File.join(HOME, ".#{dotfile}")
    move_to_trash(dest) { |symlink_target| symlink_target == source }
    FileUtils.ln_s(source, dest) unless File.exists?(dest)
  end
end
