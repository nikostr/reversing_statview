library(tidyverse)
library(Rcpp)

sourceCpp('read_float10.cpp')

read_float10_and_seek <- function(n, filecon, filename) {
  cur_pos <- seek(filecon, where=NA)
  seek(filecon, where=cur_pos + n*10)
  read_float10(n=n, offset=cur_pos, filename)
}

filename <- 'data/MEP PARA AND PLUM'
filecon <- file(filename, 'rb')
seek(filecon, where = 9593)
mep_rows = 113

mep <- tibble(
  common_names = c("raven", "carrion crow", "hooded crow", "rook", "jackdaw", "Azure-w. magpie", "jay", "nutcracker", "siberian jay", "magpie", "alpine clough", "golden oriole", "red-backed shrike", "great grey shrike", "lesser grey shrike", "woodchat shrike", "sky lark", "short-toed lark", "crested lark", "wood lark", "calandra lark", "corn bunting", "rock bunting", "cirl bunting", "yellowhammer", "ortolan bunting", "b-headed bunting", "reed bunting", "snow bunting", "linnet", "redpoll", "goldfinch", "greenfinch", "siskin", "hawfinch", "crossbill", "bullfinch", "serin", "chaffinch", "brambling", "tawny pipit", "meadow pipit", "rock pipit", "tree pipit", "pied wagtail", "grey wagtail", "yellow wagtail", "house sparrow", "spanish sparrow", "tree sparrow", "rock sparrow", "alpine accentor", "dunnock", "long-tailed tit", "house martin", "crag martin", "swallow", "sand martin", "coal tit", "blue tit", "crested tit", "great tit", "willow tit", "marsh tit", "nuthatch", "rock nuthatch", "great reed warbler", "marsh warbler", "sedge warbler", "reed warbler", "Cetti's warbler", "fan-tailed warbler", "icterine warbler", "melodius warbler", "Savi's warbler", "grasshopper warb", "Bonelli's warbler", "chiffchaff", "wood warbler", "willow warbler", "blackcap", "garden warbler", "subalpine warbler", "whitethroat", "lesser whitethroat", "orphean warbler", "sardinia warbler", "barred warbler", "firecrest", "goldcrest", "tree creeper", "wren", "dipper", "starling", "pied flycatcher", "r-b. flycatcher", "spotted flycatcher", "robin", "thrush nightingale", "nightingale", "bluethroat", "rock thrush", "b-e wheatear", "wheatear", "black redstart", "redstart", "whinchat", "redwing", "blackbird", "song thrush", "fieldfare", "ring ouzel", "mistle thrush"),
  vb_score = readBin(filecon, integer(), n=mep_rows, size = 2, endian='big'),
  kn_score = readBin(filecon, integer(), n=mep_rows, size = 2, endian = 'big'),
  rq_score = readBin(filecon, integer(), n=mep_rows, size = 2, endian = 'big'),
  rg_score = readBin(filecon, integer(), n=mep_rows, size = 2, endian = 'big'),
  av_score = readBin(filecon, integer(), n=mep_rows, size = 2, endian = 'big'),
  ar_color_score = readBin(filecon, integer(), n=mep_rows, size = 2, endian = 'big'),
  tb_score = readBin(filecon, integer(), n=mep_rows, size = 2, endian = 'big'),
  body_length = readBin(filecon, integer(), n=mep_rows, size = 2, endian = 'big'),
  num_subspecies = readBin(filecon, integer(), n=mep_rows, size = 2, endian = 'big'),
  dimorphism = readBin(filecon, integer(), n=mep_rows, size = 1, endian = 'big'),
  bill_col = readBin(filecon, integer(), n=mep_rows, size = 2, endian = 'big'),
  crown_col = readBin(filecon, integer(), n=mep_rows, size = 2, endian = 'big'),
  head_col = readBin(filecon, integer(), n=mep_rows, size = 2, endian = 'big'),
  back_col = readBin(filecon, integer(), n=mep_rows, size = 2, endian = 'big'),
  front_col = readBin(filecon, integer(), n=mep_rows, size = 2, endian = 'big'),
  belly_col = readBin(filecon, integer(), n=mep_rows, size = 2, endian = 'big'),
  leg_col = readBin(filecon, integer(), n=mep_rows, size = 2, endian = 'big'),
  upper_flash = readBin(filecon, integer(), n=mep_rows, size = 2, endian = 'big'),
  lower_flash = readBin(filecon, integer(), n=mep_rows, size = 2, endian = 'big'),
  greatest_score_diff = readBin(filecon, integer(), n=mep_rows, size = 2, endian = 'big'),
  highest_score = readBin(filecon, integer(), n=mep_rows, size = 2, endian = 'big'),
  mean_score = read_float10_and_seek(n=mep_rows, filecon=filecon, filename=filename),
  tot_caught = readBin(filecon, integer(), n=mep_rows, size = 2, endian = 'big'),
  totinf = readBin(filecon, integer(), n=mep_rows, size = 2, endian = 'big'),
  H = readBin(filecon, integer(), n=mep_rows, size = 2, endian = 'big'),
  L = readBin(filecon, integer(), n=mep_rows, size = 2, endian = 'big'),
  'T' = readBin(filecon, integer(), n=mep_rows, size = 2, endian = 'big'),
  P = readBin(filecon, integer(), n=mep_rows, size = 2, endian = 'big'),
  OP = readBin(filecon, integer(), n=mep_rows, size = 2, endian = 'big'),
  totinf_by_n = read_float10_and_seek(n=mep_rows, filecon=filecon, filename=filename),
  H_by_n = read_float10_and_seek(n=mep_rows, filecon=filecon, filename=filename),
  L_by_n = read_float10_and_seek(n=mep_rows, filecon=filecon, filename=filename),
  T_by_n = read_float10_and_seek(n=mep_rows, filecon=filecon, filename=filename),
  P_by_n = read_float10_and_seek(n=mep_rows, filecon=filecon, filename=filename),
  OP_by_n = read_float10_and_seek(n=mep_rows, filecon=filecon, filename=filename),
  nbreed = readBin(filecon, integer(), n=mep_rows, size = 2, endian = 'big'),
  sbreed = readBin(filecon, integer(), n=mep_rows, size = 2, endian = 'big'),
  nwinter = readBin(filecon, integer(), n=mep_rows, size = 2, endian = 'big'),
  swinter = readBin(filecon, integer(), n=mep_rows, size = 2, endian = 'big'),
  nbreed_sbreed_by_2 = read_float10_and_seek(n=mep_rows, filecon=filecon, filename=filename),
  nwinter_swinter_by_2 = read_float10_and_seek(n=mep_rows, filecon=filecon, filename=filename),
  mating_syst_3_cat = readBin(filecon, integer(), n=mep_rows, size = 1, endian = 'big'),
  mating_syst_2_cat = readBin(filecon, integer(), n=mep_rows, size = 1, endian = 'big'),
  incub_sex_4_cat = readBin(filecon, integer(), n=mep_rows, size = 1, endian = 'big'),
  incub_sex_3_cat = readBin(filecon, integer(), n=mep_rows, size = 1, endian = 'big'),
  feeding_greg = readBin(filecon, integer(), n=mep_rows, size = 2, endian = 'big'),
  feed_hgt = readBin(filecon, integer(), n=mep_rows, size = 2, endian = 'big'),
  lifespan = readBin(filecon, integer(), n=mep_rows, size = 2, endian = 'big'),
  nest_type = readBin(filecon, integer(), n=mep_rows, size = 1, endian = 'big'),
  diet = readBin(filecon, integer(), n=mep_rows, size = 1, endian = 'big'),
  migration = readBin(filecon, integer(), n=mep_rows, size = 1, endian = 'big'),
  nest_dispersion = readBin(filecon, integer(), n=mep_rows, size = 1, endian = 'big'),
  habitat = readBin(filecon, integer(), n=mep_rows, size = 1, endian = 'big'),
  bl.obs.pl_exp.pl = read_float10_and_seek(n=mep_rows, filecon=filecon, filename=filename),
  bl.obs.mb_exp.mb = read_float10_and_seek(n=mep_rows, filecon=filecon, filename=filename),
  nb_sb_by_2.obs.pl_exp.pl = read_float10_and_seek(n=mep_rows, filecon=filecon, filename=filename),
  nb_sb_by_2.obs.mb_exp.mb = read_float10_and_seek(n=mep_rows, filecon=filecon, filename=filename),
  nw_sw_by_2.obs.mb_exp.mb = read_float10_and_seek(n=mep_rows, filecon=filecon, filename=filename),
  nw_sw_by_2.obs.pl_exp.pl = read_float10_and_seek(n=mep_rows, filecon=filecon, filename=filename),
  bre_wint_lat = read_float10_and_seek(n=mep_rows, filecon=filecon, filename=filename),
  bre_wint_lat.obs.pl_exp.pl = read_float10_and_seek(n=mep_rows, filecon=filecon, filename=filename),
  bre_wint_lat.obs.mb_exp.mb = read_float10_and_seek(n=mep_rows, filecon=filecon, filename=filename),
  habitat_recoded = readBin(filecon, integer(), n=mep_rows, size = 1, endian = 'big'),
  arcsin_totinf_by_n = read_float10_and_seek(n=mep_rows, filecon=filecon, filename=filename),
  mean_oxf_score = read_float10_and_seek(n=mep_rows, filecon=filecon, filename=filename),
  oxf_birdos_score = read_float10_and_seek(n=mep_rows, filecon=filecon, filename=filename),
) %>%
  mutate(across(where(is.integer), ~ na_if(., -32768)))

close(filecon)


filename <- 'data/NAP+ecol var'
filecon <- file(filename, 'rb')
seek(filecon, where = 7319)
nap_rows = 114

nap <- tibble(
  common_name = c("eastern wood peewee", "g-crested f'catcher", "olive-sided f'catcher", "eastern phoebe", "eastern kingbird", "common crow", "common raven", "blue jay", "gray jay", "y-throated vireo", "warbling vireo", "solitary vireo", "white-eyed vireo", "red-eyed vireo", "philadelphia vireo", "loggerhead shrike", "cardinal", "blue grosbeak", "indigo bunting", "rose-breasted grosbeak", "Bachman's sparrow", "grasshopper sparrow", "lark sparrow", "dark-eyed junco", "song sparrow", "Lincoln's sparrow", "swamp sparrow", "savannah sparrow", "fox sparrow", "rufous-sided towhee", "vesper sparrow", "chipping sparrow", "field sparrow", "white-throated sparrow", "white-crowned sparrow", "red-winged blackbird", "orchard oriole", "northern oriole", "brown-headed cowbird", "boat-tailed grackle", "common grackle", "eastern meadowlark", "yellow warbler", "pine warbler", "Blackburnian warbler", "blackpoll warbler", "Cape May warbler", "chestnut-sided warbler", "magnolia warbler", "bk-throated blue warb.", "yellow-rumped warb.", "bk-throated green warb.", "yellow-throated warbler", "prairie warbler", "palm warbler", "Kentucky warbler", "mourning warbler", "yellowthroat", "yellow-breasted chat", "bk-&-white warbler", "northern parula", "prothonotary warb.", "ovenbird", "northern waterthrush", "Louisiana waterthrush", "American redstart", "blue-winged warbler", "orange-crowned warb.", "Tennessee warbler", "Nashville warbler", "hooded warbler", "Wilson's warbler", "Canada warbler", "summer tanager", "scarlet tanager", "pine siskin", "American goldfinch", "purple finch", "evening grosbeak", "red crossbill", "white-winged crossbill", "house sparrow", "barn swallow", "purple martin", "bank swallow", "rough-w'ed swallow", "tree swallow", "bk-capped chickadee", "carolina chickadee", "boreal chickadee", "tufted titmouse", "r-breasted nuthatch", "w-breasted nuthatch", "br-headed nuthatch", "golden-cr'ed kinglet", "ruby-cr'ed kinglet", "brown creeper", "s-billed marsh wren", "Bewick's wren", "Carolina wren", "house wren", "winter wren", "cedar waxwing", "catbird", "mockingbird", "brown thrasher", "starling", "eastern bluebird", "veery", "gray-cheeked thrush", "Swainson's thrush", "hermit thrush", "wood thrush", "American robin"),
  ar_score = readBin(filecon, integer(), n=nap_rows, size = 2, endian = 'big'),
  rq_score = readBin(filecon, integer(), n=nap_rows, size = 2, endian = 'big'),
  rg_score = readBin(filecon, integer(), n=nap_rows, size = 2, endian = 'big'),
  kn_score = readBin(filecon, integer(), n=nap_rows, size = 2, endian = 'big'),
  tb_score = readBin(filecon, integer(), n=nap_rows, size = 2, endian = 'big'),
  av_score = readBin(filecon, integer(), n=nap_rows, size = 2, endian = 'big'),
  vb_score = readBin(filecon, integer(), n=nap_rows, size = 2, endian = 'big'),
  mating_syst_3_cat = readBin(filecon, integer(), n=nap_rows, size = 1, endian = 'big'),
  mating_syst_2_cat = readBin(filecon, integer(), n=nap_rows, size = 1, endian = 'big'),
  incub_sex_3_cat = readBin(filecon, integer(), n=nap_rows, size = 1, endian = 'big'),
  nest_type = readBin(filecon, integer(), n=nap_rows, size = 1, endian = 'big'),
  diet = readBin(filecon, integer(), n=nap_rows, size = 1, endian = 'big'),
  migration = readBin(filecon, integer(), n=nap_rows, size = 1, endian = 'big'),
  nest_dispersion = readBin(filecon, integer(), n=nap_rows, size = 1, endian = 'big'),
  habitat_9_cat = readBin(filecon, integer(), n=nap_rows, size = 1, endian = 'big'),
  habitat_2_cat = readBin(filecon, integer(), n=nap_rows, size = 1, endian = 'big'),
  dimorphism = readBin(filecon, integer(), n=nap_rows, size = 1, endian = 'big'),
  num_subspecies = readBin(filecon, integer(), n=nap_rows, size = 2, endian = 'big'),
  male_length = readBin(filecon, integer(), n=nap_rows, size = 2, endian = 'big'),
  female_length = readBin(filecon, integer(), n=nap_rows, size = 2, endian = 'big'),
  male_bright = readBin(filecon, integer(), n=nap_rows, size = 2, endian = 'big'),
  female_bright = readBin(filecon, integer(), n=nap_rows, size = 2, endian = 'big'),
  male_song = readBin(filecon, integer(), n=nap_rows, size = 2, endian = 'big'),
  mb_fb = readBin(filecon, integer(), n=nap_rows, size = 2, endian = 'big'),
  mb_fb_msu = readBin(filecon, integer(), n=nap_rows, size = 2, endian = 'big'),
  tot_caught = readBin(filecon, integer(), n=nap_rows, size = 2, endian = 'big'),
  totinf = readBin(filecon, integer(), n=nap_rows, size = 2, endian = 'big'),
  L = readBin(filecon, integer(), n=nap_rows, size = 2, endian = 'big'),
  H = readBin(filecon, integer(), n=nap_rows, size = 2, endian = 'big'),
  P = readBin(filecon, integer(), n=nap_rows, size = 2, endian = 'big'),
  TRY = readBin(filecon, integer(), n=nap_rows, size = 2, endian = 'big'),
  MICRO = readBin(filecon, integer(), n=nap_rows, size = 2, endian = 'big'),
  OP = readBin(filecon, integer(), n=nap_rows, size = 2, endian = 'big'),
  totinf_by_n = read_float10_and_seek(n=nap_rows, filecon=filecon, filename=filename),
  L_by_n = read_float10_and_seek(n=nap_rows, filecon=filecon, filename=filename),
  H_by_n = read_float10_and_seek(n=nap_rows, filecon=filecon, filename=filename),
  P_by_n = read_float10_and_seek(n=nap_rows, filecon=filecon, filename=filename),
  TRY_by_n = read_float10_and_seek(n=nap_rows, filecon=filecon, filename=filename),
  MICRO_by_n = read_float10_and_seek(n=nap_rows, filecon=filecon, filename=filename),
  OP_by_n = read_float10_and_seek(n=nap_rows, filecon=filecon, filename=filename),
  log_male_length = read_float10_and_seek(n=nap_rows, filecon=filecon, filename=filename),
  rq_dev = readBin(filecon, integer(), n=nap_rows, size = 2, endian = 'big'),
  tb_dev = readBin(filecon, integer(), n=nap_rows, size = 2, endian = 'big'),
  rg_dev = readBin(filecon, integer(), n=nap_rows, size = 2, endian = 'big'),
  kn_dev = readBin(filecon, integer(), n=nap_rows, size = 2, endian = 'big'),
  av_dev = readBin(filecon, integer(), n=nap_rows, size = 2, endian = 'big'),
  vb_dev = readBin(filecon, integer(), n=nap_rows, size = 2, endian = 'big'),
  unknown_categorical = readBin(filecon, integer(), n=nap_rows, size = 1, endian = 'big'),
  mean_dev = read_float10_and_seek(n=nap_rows, filecon=filecon, filename=filename),
  mean_oxford_score = read_float10_and_seek(n=nap_rows, filecon=filecon, filename=filename),
) %>%
  mutate(across(where(is.integer), ~ na_if(., -32768)))

close(filecon)
