#!/usr/bin/env python
import argparse
import os

version = "0.0.1"
parser = argparse.ArgumentParser("""BlobFish-{}""".format(version),add_help=False)
parser.add_argument('--allvsall' , help="Compare all individuals/samples/timepoints etc", required=False, action="store_true")
args, unknown = parser.parse_known_args()



if args.allvsall:
	parser = argparse.ArgumentParser("""BlobFish-{}""".format(version))
	parser.add_argument('--allvsall' , help="Compare all individuals/samples/timepoints etc", required=False, action="store_true")
	parser.add_argument('--paths', type=str,required=True,  help="path to salmon output directories (multiple directories are separated by \" \", eachdirecotry contain a quant.sf file", nargs='+')
        parser.add_argument('--sample', type=str,required=True,  help="sample specification, the sample name for each input,separated by \" \", there should be one sample name for each input path", nargs='+')
	parser.add_argument('--dir', type=str,required=True,  help="The output is printed to this directory")
	parser.add_argument('--tx', type=str,required=True,  help="The transcript to gene file")
	args= parser.parse_args()

	os.system("mkdir -p {}".format(args.dir))
	if not len(args.paths) == len(args.sample):
		print "Error: you need to specify one sample id for each input path"
		quit()

	args.wd=os.path.dirname(os.path.realpath(__file__))

	sample_list={}
	for i in range(0,len(args.paths)):
		if not args.sample[i] in sample_list:
			sample_list[args.sample[i]] = []

		sample_list[args.sample[i]].append(args.paths[i])

    
	for a in sample_list:	
		for b in sample_list:
			if a == b or b < a:
				continue
			print [a,b]

			config=open("{}/{}_vs_{}.tab".format(args.dir,a,b,),"w")
			config.write("run sample path\n")

			i=0
			for run in sample_list[a]:
				config.write("run{} {} {}\n".format(i,a,run))
				i+=1

			for run in sample_list[b]:
				config.write("run{} {} {}\n".format(i,b,run))
				i+=1

			config.close()
			print "Rscript {}/BlobFish.R --sample {} --tx {} > {}/{}_vs_{}.results.tsv".format(args.wd,"{}/{}_vs_{}.tab".format(args.dir,a,b),args.tx,args.dir,a,b)
			os.system("Rscript {}/BlobFish.R --sample {} --tx {} > {}/{}_vs_{}.results.tsv".format(args.wd,"{}/{}_vs_{}.tab".format(args.dir,a,b),args.tx,args.dir,a,b))
		

				
else:
	print "error, missing argument, type:"
	print "python BlobFish.py --allvsall --help"
	


