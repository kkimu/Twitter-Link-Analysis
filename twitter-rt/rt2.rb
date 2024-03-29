t0 = Time.now

fnlist = []
fnlist2 = []
open("filename.txt").each do |fn|
  fnlist << fn.strip
end
open("filename2.txt").each do |fn|
  fnlist2 << fn.strip
end


for i in 1..1
  t1 = Time.now
  idlist = Hash.new
  open("../id_list_#{i}.txt").each do |id|
    idlist[id.rstrip] = 1
  end
  
  rt = Hash.new{|hash,key| hash[key] = Array.new}
  
  fnlist.each do |fn|
    t2 = Time.now
    print fn+" "
    open("data/2013-12/#{fn}").each do |line|
      sp = line.strip.split("\t")
      if idlist[sp[1]] == 1 && idlist[sp[5]] == 1
        rt[sp[5]] << sp[1]
      end
    end
    puts "time:#{Time.now - t2}"
  end
  
  fnlist2.each do |fn|
    t2 = Time.now
    print fn+" "
    open("data/2014-01/#{fn}").each do |line|
      sp = line.strip.split("\t")
      if idlist[sp[1]] == 1 && idlist[sp[5]] == 1
        rt[sp[5]] << sp[1]
      end
    end
    puts "time:#{Time.now - t2}"
  end

  open("result/rt_result_#{i}.txt","w") do |f|
    rt.each do |k,v|
      rt[k] = v.uniq.length
    end
    rt.sort_by{|k,v| -v}.each do |k,v|
      f.puts "#{k} #{v}"
    end
  end
  puts "time_#{i}:#{Time.now - t1}"
end

puts "total time:#{Time.now - t0}"
