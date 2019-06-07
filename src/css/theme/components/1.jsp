<%@ page contentType="text/html; charset=UTF-8" %>

<%@ include file="../init.jsp" %>

<div id="<portlet:namespace />Root" class="messages-portlet">
    <%@ include file="/include/mixAlert.jspf" %>
    <%@ include file="/include/mixLoading.jspf" %>
    <div class="messages-portlet-sub">
            <!-- FILTERS-PANEL START -->
            <div class="filters-panel" v-bind:class="{ active: isPanelActive }" id="filtersPanel">
                <div class="filters-panel__btn active" v-on:click="isPanelActive = !isPanelActive" id="filtersBtn">
                    <span>Show filters</span>
                    <span class="collapse-icon-closed">
                                    <i class="fas fa-chevron-left"></i>
                                </span>
                    <span class="collapse-icon-open">
                                    <i class="fas fa-chevron-right"></i>
                                </span>
                    <span class="search-mobile">
                                    <i class="fas fa-search"></i>
                                </span>
                </div>
                <div class="filters-panel__body" v-show="isPanelActive">
                    <form>
                        <!-- SEARCH & FILTER STARTS -->
                        <div class="filter-category">
                            <div class="filter-category__title">search & filter
                                <span class="tooltip-cims tooltip-cims--right" data-tooltip="I'm small tooltip. Don't kill me!">
                                                <i class="fas fa-question-circle"></i>
                                                <span class="tooltip-cims__text" data-tooltip="I'm tooltip"></span>
                                            </span>
                            </div>
                            <div class="filter-category__body">
                                <div class="[ row no-gutters ] filter-category__item">
                                    <div class="col-8 offset-3">
                                        <div class="select-container">
                                            <select class="cims-select filter-category__control" required>
                                                <option value="" disabled selected hidden>Select saved filter</option>
                                                <option v-for="opt in savedUserFilters" :key="opt.id" :value="opt.id">{{ opt.name }}</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="col-1">

                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- SEARCH & FILTER END -->

                        <!-- TEXT & PERIOD FILTER STARTS -->
                        <div class="filter-category">
                            <a class="filter-category__head collapse-icon" aria-controls="textFilterBody"
                               aria-expanded="true" data-toggle="collapse" href="#textFilterBody" id="textFilter" role="tab">
                                <span class="filter-category__title">text & period filter</span>
                                <span class="tooltip-cims tooltip-cims--right" data-tooltip="I'm small tooltip. Don't kill me!">
                                                <i class="fas fa-question-circle"></i>
                                                <span class="tooltip-cims__text" data-tooltip="I'm tooltip"></span>
                                            </span>
                                <span class="collapse-icon-closed">
                                                <i class="fas fa-chevron-down"></i>
                                            </span>
                                <span class="collapse-icon-open">
                                                <i class="fas fa-chevron-up"></i>
                                            </span>
                            </a>
                            <div class="filter-category__body collapse show" aria-labelledby="textFilter" id="textFilterBody" role="tabpanel">
                                <div class="[ row no-gutters ] filter-category__item">
                                    <div class="col-3">
                                        <label class="filter-category__label">Posted:</label>
                                    </div>

                                    <div class="col-8">
                                        <div class="select-container select-container--icon-right">
                                            <el-date-picker
                                                v-model="filter.dateInRange"
                                                type="daterange"
                                                language="en"
                                                start-placeholder="Start date"
                                                end-placeholder="End date"
                                                :default-time="['00:00:00', '23:59:59']"
                                                :picker-options="dateRangePickOptions">
                                            </el-date-picker>
                                        </div>
                                    </div>

                                </div>

                                <div class="[ row no-gutters ] filter-category__item">
                                    <div class="col-3">
                                        <label class="filter-category__label">Text Search:</label>
                                    </div>

                                    <div class="col-8">
                                        <input type="text" class="cims-input filter-category__control" placeholder="Search title or message" v-model="filter.keywords">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- TEXT & PERIOD FILTER END -->

                        <!-- EXTENDED TEXT SEARCH START -->
                        <div class="filter-category">

                            <a class="filter-category__head collapse-icon" aria-controls="extendedTextSearchBody"
                               aria-expanded="true" data-toggle="collapse" href="#extendedTextSearchBody" id="extendedTextSearch" role="tab">
                                <span class="filter-category__title">extended text search</span>
                                <span class="tooltip-cims tooltip-cims--right" data-tooltip="I'm small tooltip. Don't kill me!">
                                                <i class="fas fa-question-circle"></i>
                                                <span class="tooltip-cims__text" data-tooltip="I'm another tooltip"></span>
                                            </span>
                                <span class="collapse-icon-closed">
                                                <i class="fas fa-chevron-down"></i>
                                            </span>
                                <span class="collapse-icon-open">
                                                <i class="fas fa-chevron-up"></i>
                                            </span>
                            </a>

                            <div class="filter-category__body collapse show" aria-labelledby="extendedTextSearch" id="extendedTextSearchBody" role="tabpanel">
                                <div class="filter-category__section" v-for="(extItem, extIndex) in filter.extendedKeywords">
                                    <div class="filter-category__item" v-if="extIndex > 0">
                                        <el-radio-group v-model="extItem.blockCondition" class="radio-group radio-group--main">
                                            <el-radio-button label="And">And</el-radio-button>
                                            <el-radio-button label="Or">Or</el-radio-button>
                                            <el-radio-button label="Exclude">Exclude</el-radio-button>
                                        </el-radio-group>

                                    </div>

                                    <div class="[ row no-gutters ]  filter-category__item">
                                        <div class="col-3">
                                            <label class="filter-category__label">Field:</label>
                                        </div>

                                        <div class="col-8">
                                            <div class="select-container">
                                                <select class="cims-select filter-category__control" v-model="extItem.fieldName">
                                                    <option v-for="opt in fieldNames" :key="opt.fieldName" :value="opt.fieldName">{{ opt.label }}</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="[ row no-gutters ] filter-category__item">
                                        <div class="col-8 offset-3">
                                            <el-radio-group v-model="extItem.containsCond" class="radio-group">
                                                <el-radio-button label="Contains">Contains</el-radio-button>
                                                <el-radio-button label="Not_contains">Not contains</el-radio-button>
                                            </el-radio-group>

                                        </div>
                                    </div>

                                    <div class="[ row no-gutters ]  filter-category__item">
                                        <div class="col-3">
                                            <label class="filter-category__label">Search Term:</label>
                                        </div>

                                        <div class="col-8">
                                            <input type="text" class="cims-input filter-category__control" v-model="extItem.keyword">
                                        </div>
                                    </div>
                                    <div class="filter-category__item category-control category-control--plus">
                                        <a href="javascript:void(0)" class="btn-link filter-btn" v-on:click="addExtendedKeyword(extIndex)">
                                            <i class="fas fa-plus-square"></i>
                                            Add Extended Group
                                        </a>
                                        <a href="javascript:void(0)" class="btn-link filter-btn" v-on:click="removeExtendedKeyword(extIndex)">
                                            <i class="fas fa-minus-square"></i>
                                            Remove Extended Group
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- EXTENDED TEXT SEARCH END -->

                        <!-- CATEGORY FILTER START -->
                        <div class="filter-category">

                            <a class="filter-category__head collapse-icon" aria-controls="categoryFilterBody"
                               aria-expanded="true" data-toggle="collapse" href="#categoryFilterBody" id="categoryFilter" role="tab">
                                <span class="filter-category__title">category filter</span>
                                <span class="tooltip-cims tooltip-cims--right" data-tooltip="I'm small tooltip. Don't kill me!">
                                                <i class="fas fa-question-circle"></i>
                                                <span class="tooltip-cims__text" data-tooltip="I'm another tooltip"></span>
                                            </span>
                                <span class="collapse-icon-closed">
                                                <i class="fas fa-chevron-down"></i>
                                            </span>
                                <span class="collapse-icon-open">
                                                <i class="fas fa-chevron-up"></i>
                                            </span>
                            </a>

                            <div class="filter-category__body collapse show" aria-labelledby="categoryFilter" id="categoryFilterBody" role="tabpanel">
                                <div v-for="(catBlock, catBlockIndex) in filter.categoryBlocks" class="filter-category__section">
                                    <div class="filter-category__item">
                                        <div class="filter-category__item" v-if="catBlockIndex > 0">
                                            <el-radio-group v-model="catBlock.blockCondition" class="radio-group radio-group--main">
                                                <el-radio-button label="And">And</el-radio-button>
                                                <el-radio-button label="Or">Or</el-radio-button>
                                                <el-radio-button label="Exclude">Exclude</el-radio-button>
                                            </el-radio-group>

                                        </div>
                                    </div>

                                    <div class="[ row no-gutters ]  filter-category__item">
                                        <div class="col-3">
                                            <label class="filter-category__label">Category:</label>
                                        </div >
                                        <div class="col-8">
                                            <div aria-expanded="true" class="input-container" v-on:click="setCategoryBlockIndex(catBlockIndex)">
                                                <el-autocomplete
                                                        v-model="categorySearchResult"
                                                        :fetch-suggestions="categorySearch"
                                                        value-key="name"
                                                        placeholder="Search category"
                                                        :trigger-on-focus="false"
                                                        @select="selectPlainCategory"
                                                ></el-autocomplete>
                                            </div>
                                        </div>
                                        <div class="col-1">
                                            <div class="open-icon" aria-expanded="true"
                                                 class="tree-heading"  role="tab" v-on:click="selectCategory(catBlockIndex)">
                                                <i class="fas fa-folder"></i>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="[ row no-gutters ] filter-category__item">
                                        <div class="col-8 offset-3">
                                            <el-radio-group v-model="catBlock.categoryCondition" class="radio-group">
                                                <el-radio-button label="And">And</el-radio-button>
                                                <el-radio-button label="Or">Or</el-radio-button>
                                            </el-radio-group>

                                        </div>
                                    </div>

                                    <div class="filter-category__item">
                                        <ul class="category category--unrating">
                                            <li v-for="(cat, index) in getFilterCategories(catBlockIndex, false)" :class="'category__item category__item--' + ((cat.ratingCategory == true)?'rating':'unrating')">
                                                <span class="category__delete"  v-on:click="removeFilterCategory(catBlockIndex, cat.id)">&#10006;</span>
                                                <span class="category__type"><i class="icon-tag"></i></span>
                                                <span class="category__name">{{ cat.name }}</span>
                                            </li>
                                        </ul>
                                        <ul class="category category--rating">
                                            <li v-for="(cat, index) in getFilterCategories(catBlockIndex, true)" :class="'category__item category__item--' + ((cat.ratingCategory == true)?'rating':'unrating')">
                                                <span class="category__delete"  v-on:click="removeFilterCategory(catBlockIndex, cat.id)">&#10006;</span>
                                                <span class="category__type"><i class="icon-star"></i></span>
                                                <span class="category__name">{{ cat.name }}</span>
                                                <div class="category__value" v-if="cat.ratingCategory && hasTonality(cat)">
                                                    <label :class="tonalityClasses(cat)" v-on:click="selectTonality(cat, catBlockIndex)"></label>
                                                </div>
                                                <div class="category__value" v-if="cat.ratingCategory && !hasTonality(cat)">
                                                    <a href="javascript:void(0)" class="btn-link add-tonality" v-on:click="selectTonality(cat, catBlockIndex)">
                                                        <i class="fas fa-plus-square"></i>
                                                        Add Tonality
                                                    </a>
                                                </div>
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="filter-category__item category-control category-control--plus">
                                        <a href="javascript:void(0)" class="btn-link filter-btn" v-on:click="addCategoryBlock(catBlockIndex)">
                                            <i class="fas fa-plus-square"></i>
                                            Add Filter Group
                                        </a>
                                        <a href="javascript:void(0)" class="btn-link filter-btn" v-on:click="removeCategoryBlock(catBlockIndex)">
                                            <i class="fas fa-minus-square"></i>
                                            Remove Filter Group
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- CATEGORY FILTER END -->

                        <!-- ADMIN FILTER STARTS -->
                        <div class="filter-category" v-if="isAdminFilterAvailable()">
                            <a class="filter-category__head collapse-icon" aria-controls="adminFilterBody"
                               aria-expanded="true" data-toggle="collapse" href="#adminFilterBody" id="adminFilter" role="tab">
                                <span class="filter-category__title">admin filter</span>
                                <span class="tooltip-cims tooltip-cims--right" data-tooltip="I'm small tooltip. Don't kill me!">
                                                <i class="fas fa-question-circle"></i>
                                                <span class="tooltip-cims__text" data-tooltip="I'm another tooltip"></span>
                                            </span>
                                <span class="collapse-icon-closed">
                                                <i class="fas fa-chevron-down"></i>
                                            </span>
                                <span class="collapse-icon-open">
                                                <i class="fas fa-chevron-up"></i>
                                            </span>
                            </a>
                            <div class="filter-category__body collapse show" aria-labelledby="adminFilter" id="adminFilterBody" role="tabpanel">
                                <div class="[ row no-gutters ] filter-category__item">
                                    <div class="col-3">
                                        <label class="filter-category__label">Created:</label>
                                    </div>

                                    <div class="col-8">
                                        
                                        <div class="select-container select-container--icon-right">
                                            <el-date-picker
                                                v-model="filter.dateCreateRange"
                                                type="daterange"
                                                language="en"
                                                start-placeholder="Start date"
                                                end-placeholder="End date"
                                                :default-time="['00:00:00', '23:59:59']"
                                                :picker-options="dateRangePickOptions">
                                            </el-date-picker>
                                        </div>

                                    </div>
                                </div>

                                <div class="[ row no-gutters ] filter-category__item">
                                    <div class="col-3">
                                        <label class="filter-category__label">Changed:</label>
                                    </div>

                                    <div class="col-8">
                                        
                                        <div class="select-container select-container--icon-right">
                                            <el-date-picker
                                                v-model="filter.dateChangeRange"
                                                type="daterange"
                                                language="en"
                                                start-placeholder="Start date"
                                                end-placeholder="End date"
                                                :default-time="['00:00:00', '23:59:59']"
                                                :picker-options="dateRangePickOptions">
                                            </el-date-picker>
                                        </div>
                                    </div>
                                </div>

                                <div class="[ row no-gutters ]  filter-category__item">
                                    <div class="col-3">
                                        <label class="filter-category__label">Msg Status:</label>
                                    </div>

                                    <div class="col-8">
                                        <div class="select-container">
                                            <select class="cims-select filter-category__control" v-model="filter.workflowStatusId">
                                                <option :value="0">Any</option>
                                                <option v-for="item in workflowStatuses" :key="item.id" :value="item.id">{{ item.name }}</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <div class="[ row no-gutters ]  filter-category__item">
                                    <div class="col-3">
                                        <label class="filter-category__label">Feed:</label>
                                    </div>

                                    <div class="col-8">
                                        <div class="select-container">
                                            <select class="cims-select filter-category__control" v-model="filter.feed">
                                                <option :value="0">Any</option>
                                                <option v-for="item in feeds" :key="item.id" :value="item.id">{{ item.name }}</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <div class="[ row no-gutters ] filter-category__item">
                                    <div class="col-3">
                                        <label class="filter-category__label">User:</label>
                                    </div>

                                    <div class="col-8">
                                        <div class="select-container">
                                                <el-select
                                                    v-model="filter.userIds"
                                                    multiple
                                                    collapse-tags
                                                    placeholder="Select users">
                                                <el-option
                                                        v-for="item in users"
                                                        :key="item.userId"
                                                        :label="item.screenName"
                                                        :value="item.userId">
                                                    <span>{{ item.screenName }}</span>
                                                </el-option>
                                            </el-select>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- ADMIN FILTER END -->

                        <div class="filter-category">
                            <a class="filter-category__head collapse-icon" aria-controls="miscellanousFilterBody"
                               aria-expanded="true" data-toggle="collapse" href="#miscellanousFilterBody" id="miscellanousFilter" role="tab">
                                <span class="filter-category__title">miscellanous filter</span>
                                <span class="tooltip-cims tooltip-cims--right" data-tooltip="I'm small tooltip. Don't kill me!">
                                                <i class="fas fa-question-circle"></i>
                                                <span class="tooltip-cims__text" data-tooltip="I'm another tooltip"></span>
                                            </span>
                                <span class="collapse-icon-closed">
                                                <i class="fas fa-chevron-down"></i>
                                            </span>
                                <span class="collapse-icon-open">
                                                <i class="fas fa-chevron-up"></i>
                                            </span>
                            </a>

                            <div class="filter-category__body collapse show" aria-labelledby="miscellanousFilter" id="miscellanousFilterBody" role="tabpanel">

                                <div class="[ row no-gutters ] filter-category__item">
                                    <div class="col-3">
                                        <label class="filter-category__label">Status:</label>
                                    </div>

                                    <div class="col-8">
                                        <div class="select-container">
                                            <select class="cims-select filter-category__control" v-model="filter.statusId">
                                                <option value="0">Any</option>
                                                <option v-for="item in cimsStatuses" :key="item.id" :value="item.id" >{{ item.name }}</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>

                                <div class="[ row no-gutters ] filter-category__item">
                                    <div class="col-3">
                                        <label class="filter-category__label">Source:</label>
                                    </div>

                                    <div class="col-8">
                                        <div class="select-container">
                                            <input type="text" autocomplete="off" class="cims-input filter-category__control dropdown-toggle" data-toggle="dropdown"
                                                   readonly value="Source" placeholder="Select source" id="source-input" data-toggle="dropdown" v-model="filter.source.name">
                                            <div ref="dropdownSource" class="dropdown-menu dropdown-tree" id="source" aria-labelledby="source-input">
                                                <el-tree
                                                        :data="sourceTree"
                                                        :props="sourceTreeProps"
                                                        default-expand-all
                                                        highlight-current
                                                        :expand-on-click-node="false"
                                                        @node-click="onSourceNodeClick"
                                                        ref="treeResources">
                                                            <span class="el-tree__wrapper" slot-scope="{ node, data }">{{ data.name }}</span>
                                                </el-tree>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="[ row no-gutters ] filter-category__item">
                                    <div class="col-3">&nbsp;</div>
                                    <div class="col-8 slider-range-views">
                                        <span>{{ filter.views[0] }}</span>
                                        <span>{{ filter.views[1] }}</span>
                                    </div>

                                    <div class="col-3">
                                        <label class="filter-category__label">Views:</label>
                                    </div>

                                    <div class="col-8">
                                        <el-slider
                                                v-model="filter.views"
                                                range
                                                :show-tooltip="true"
                                                :max="viewsMax"
                                                :min="viewsMin">
                                        </el-slider>
                                    </div>

                                    <div class="col-3">&nbsp;</div>
                                    <div class="col-8 slider-range-views">
                                        <span>{{ viewsMin }}</span>
                                        <span>{{ viewsMax }}</span>
                                    </div>
                                    
                                </div>
                            </div>
                        </div>

                        <div class="btn-container btn-container--center">
                            <a href="javascript:void(0)" class="btn-link" value="save" v-on:click="">
                                <i class="fas fa-save"></i>
                                Save filter
                            </a>
                        </div>

                        <div class="btn-container btn-container--center">
                            <a href="javascript:void(0)" class="btn-link" value="reset" v-on:click="clearFilters($event)">
                                <i class="far fa-trash-alt"></i>
                                Reset
                            </a>
                            <a href="javascript:void(0)" class="btn-link btn-link--primary" v-on:click="doSearch($event)">
                                <i class="fas fa-search"></i>
                                Submit
                            </a>
                        </div>
                    </form>
                </div>
            </div>
            <!-- FILTERS-PANEL ENDS -->


            <div class="messages">
                <div class="messages-settings">
                    <div class="messages-settings__item">
                        <label class="custom-checkbox">
                            <input type="checkbox" name="test" v-model="markedAll"/>
                            <span class="mark-icon">Mark all messages</span>
                        </label>
                    </div>
                    <div class="messages-settings__item">
                        <a href="#" class="link-icon">
                            <span><i class="fas fa-envelope"></i></span>
                            Add marked to newsletter
                        </a>
                    </div>
                    <div class="messages-settings__item">
                        <a href="#" class="link-icon">
                            <span><i class="fas fa-download"></i></span>
                            Export filtered
                        </a>
                    </div>
                    <div class="messages-settings__item">
                        <a href="javascript:void(0)" class="link-icon" v-on:click="publishMarked()">
                            <span><i class="fas fa-check"></i></span>
                            Publish marked
                        </a>
                    </div>
                    <div class="messages-settings__item">
                        <a href="#" class="link-icon">
                            <span><i class="far fa-trash-alt"></i></span>
                            Delete marked
                        </a>
                    </div>
                    <div class="messages-settings__item">
                        <label class="toggle-switch">
                            <el-switch v-model="showTranslation"
                                    active-color="#272833"
                                    inactive-color="#DCDCDC"
                                    active-text="Show Translation" />
                            <span>Show Translation</span>
                        </label>
                    </div>
                    <div class="messages-settings__item">
                        <label class="toggle-switch">
                            <el-switch v-model="showHtmlSource"
                                       active-color="#272833"
                                       inactive-color="#DCDCDC"
                                       active-text="Show html source" />
                            <span>Show html source</span>
                        </label>
                    </div>
                </div>

                <div class="messages-settings">
                    <div class="page-pagination">
                        <ul class="page-pagination__list">
                            <li class="page-pagination__item">
                                <a class="page-pagination__link" href="javascript:void(0)" role="button" v-on:click="gotoFirstPage()">
                                    <i class="fas fa-step-backward"></i>
                                </a>
                            </li>
                            <li class="page-pagination__item">
                                <a class="page-pagination__link" href="javascript:void(0)" role="button" v-on:click="gotoPrevPage()">
                                    <i class="fas fa-chevron-left"></i>
                                </a>
                            </li>
                            <li v-for="pageIndex in pageIndexesForDisplay" :key="pageIndex" :class="(pageIndex == pageNo)?'active page-pagination__item':'page-pagination__item'">
                                <a v-if="pageIndex > 0" class="page-pagination__link" href="javascript:void(0)" v-on:click="gotoPage(pageIndex)">{{ pageIndex }}</a>
                                <span v-else >...</span>
                            </li>
                            <li class="page-pagination__item">
                                <a class="page-pagination__link" href="javascript:void(0)" role="button" v-on:click="gotoNextPage()">
                                    <i class="fas fa-chevron-right"></i>
                                </a>
                            </li>
                            <li class="page-pagination__item">
                                <a class="page-pagination__link" href="javascript:void(0)" role="button" v-on:click="gotoLastPage()">
                                    <i class="fas fa-step-forward"></i>
                                </a>
                            </li>
                        </ul>
                        <div class="page-pagination__results">Page {{ pageNo }} of {{ pageCount }} ({{ messageCount }} messages in total)</div>
                        <div class="select-container">
                            <select class="cims-select filter-category__control" v-model="pageSize">
                                <option v-for="item in pageSizeOptions" :key="item" :value="item">{{ item }} per page</option>
                            </select>
                        </div>
                    </div>

                    <div class="select-container">
                        <select class="cims-select" v-model="messageSorting" v-on:change="onMessageSortingChanged($event)">
                            <option  v-for="opt in messageSortingOptions" v-bind:value="opt.value">{{ opt.label }}</option>
                        </select>
                    </div>
                </div>

                <div class="messages-container">
                    <div v-if="messageCount == 0">No messages found</div>
                    <div class="message-item" v-for="cimsMessage in messageList">
                        <div class="message-item__head">
                            <span :class="getMessageStatusStyle(cimsMessage)"><i class="icon-sun"></i>{{ cimsMessage.status.name }}</span>
                            <div class="message-item__main-content">
                                <h3 class="message-item__heading"><a :href="cimsMessage.url" target="_blank">{{ cimsMessage.title }}</a></h3>
                                <p class="message-item__text" v-if="showHtmlSource">{{ cimsMessage.shortText }}</p>
                                <p class="message-item__text" v-else v-html="cimsMessage.shortText"></p>

                                <div class="message-item__translation" v-show="showTranslation && cimsMessage.hasTranslation">
                                    <h3 class="message-item__heading"><a :href="cimsMessage.url" target="_blank">{{ cimsMessage.titleTransl }}</a></h3>
                                    <p class="message-item__text" v-if="showHtmlSource">{{ cimsMessage.shortTextTransl }}</p>
                                    <p class="message-item__text" v-else v-html="cimsMessage.shortTextTransl"></p>
                                    <span class="label label-success">
                                        <span class="label-item label-item-expand">translated</span>
                                    </span>
                                </div>

                            </div>

                            <div class="message-item__logo">
                                <img class="" src="images/message-logo.jpg" alt="message logo">
                            </div>
                            <div class="message-item__rating">
                                <ul class="category category--unrating">
                                    <li class="category__item" v-for="cat in cimsMessage.assignmentsTagged">
                                        <span class="category__type"><i class="icon-tag"></i></span>
                                        <span class="category__name">{{ cat.categoryName }}</span>
                                    </li>
                                </ul>
                                <ul class="category category--rating">
                                    <li class="category__item" v-for="cat in cimsMessage.assignmentsRated">
                                        <span class="category__type"><i class="icon-star"></i></span>
                                        <span class="category__name">{{ cat.categoryName }}</span>
                                        <div class="category__value">
                                            <span :class="getCategoryClasses(cat)"></span>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="message-item__history" v-show="cimsMessage.showHistory == 1">
                            <div class="close">
                                <i class="fas fa-times" v-on:click="cimsMessage.showHistory = 0"></i>
                            </div>

                            <table class="table message-table">
                                <thead>
                                <tr>
                                    <th>Date</th>
                                    <th>Editor</th>
                                    <th>Description</th>
                                    <th>Comment</th>
                                </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td></td>
                                        <td>{{ themeDisplay.user.firstName }} {{ themeDisplay.user.lastName }}</td>
                                        <td>
                                            <div class="select-container">
                                                <select class="cims-select" v-model="cimsMessage.workflowStatusNew">
                                                    <option v-for="item in workflowStatuses" :key="item.id" :value="item.id">{{ item.name }}</option>
                                                </select>
                                            </div>
                                        </td>
                                        <td>
                                            <input type="text" class="cims-input" v-model="cimsMessage.commentNew">
                                            <button class="cims-btn cims-btn--primary" v-on:click="onWorkflow(cimsMessage.id)">Save</button>
                                        </td>
                                    </tr>
                                    <tr v-for="hist in cimsMessage.history">
                                        <td>{{ hist.eventDateAsString }}</td>
                                        <td>
                                            <span v-if="hist.user">{{ hist.user.firstName }} {{ hist.user.lastName }}</span>
                                            <span v-else>Unknown user with id {{ hist.userId }}</span>
                                        </td>
                                        <td>{{ hist.eventType }}</td>
                                        <td>
                                            <span v-if="hist.workflowStatus">{{ hist.workflowStatus.name }}</span>
                                            <span>{{ hist.comment }}</span>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>

                        </div>
                        <div class="message-item__footer">
                            <ul class="message-information">
                                <li class="message-information__item">
                                    <span class="message-information__name message-information__name--url-name" href="javascript:void(0)">{{ cimsMessage.sourceSite.name }}</span>
                                </li>
                                <li class="message-information__item">
                                    <span class="message-information__name message-information__name--time">{{ filterDMYHM(cimsMessage.dateIn) }}</span>
                                </li>
                                <li class="message-information__item">
                                    <span class="message-information__name message-information__name--views">{{ cimsMessage.views }}</span>
                                </li>
                                <li class="message-information__item">
                                    <a class="message-information__name message-information__name--url-link" :href="cimsMessage.url" target="blank">URL</a>
                                </li>
                            </ul>

                            <ul class="message-information">
                                <li class="message-information__item">
                                    <a href="javascript:void(0)" v-on:click="openForEdit(cimsMessage.id)" class="link-icon">
                                        <span><i class="fas fa-pen"></i></span>
                                        Edit
                                    </a>
                                </li>
                                <li class="message-information__item">
                                    <a href="javascript:void(0)" v-on:click="loadHistory(cimsMessage.id)" class="link-icon link-history">
                                        <span><i class="fas fa-history"></i></span>
                                        History
                                    </a>    
                                </li>
                                <li class="message-information__item">
                                    <label class="custom-checkbox">
                                        <input type="checkbox" v-model="cimsMessage.marked" />
                                        <span class="mark-icon">Marked</span>
                                    </label>
                                </li>

                            </ul>
                        </div>
                    </div>

                </div>

            </div>
        </div>
    <el-dialog title="Powertrain" :visible.sync="dlgTonalityVisible" custom-class="tonality-popup">
        <span>negative</span>
        <div class="tonality-popup__group">
            <span v-for="ts in tonalityScale" :class="'tonality-popup__btn tonality-popup__btn--negative-' + ts.toString()" v-on:click="onTonalitySelected(-1, ts)">{{ ts }}%</span>
        </div>
        <span>neutral</span>
        <div class="tonality-popup__group">
            <span v-for="ts in tonalityScale" :class="'tonality-popup__btn tonality-popup__btn--neutral-' + ts.toString()" v-on:click="onTonalitySelected(0, ts)">{{ ts }}%</span>
        </div>
        <span>positive</span>
        <div class="tonality-popup__group">
            <span v-for="ts in tonalityScale" :class="'tonality-popup__btn tonality-popup__btn--positive-' + ts.toString()" v-on:click="onTonalitySelected(1, ts)">{{ ts }}%</span>
        </div>
    </el-dialog>

    <el-dialog :visible.sync="dlgCategoryVisible" custom-class="category-popup">
        <a href="javascript:void(0)" title="expand all"  v-on:click="expandAll">expand all</a>
        <a href="javascript:void(0)" title="collapse all" v-on:click="collapseAll">collapse all</a>
        <input type="text" class="cims-input filter-category__control" placeholder="Search title or message" v-model="dlgCategorySearchText">
        <div role="tabpanel">
            <el-tree
                    class="filter-tree table-tree"
                    :data="categoryTree"
                    :props="categoryTreeProps"
                    default-expand-all
                    :expand-on-click-node="false"
                    highlight-current
                    :filter-node-method="doFilterCategoryTree"
                    @node-click="onCategoryNodeClick"
                    ref="treeCategories">
                        <span slot-scope="{ node, data }">
                            <a href="javascript:void(0)" :class="'jstree-anchor' + (data.ratingCategory === true?' jstree-rating':'') + (data.assigned === false?'':' tree-category--disabled')" v-on:click="selectCategoryFromTree(data, node, null)">
                                <i class="jstree-icon jstree-themeicon" role="presentation"></i>
                                {{ node.label }}
                            </a>
                        </span>
            </el-tree>
        </div>
    </el-dialog>

</div>

<%@ include file="/components/cims-datepicker/CimsDatepickerTemplate.jsp" %>

<aui:script require="<%= mainRequire + "/lib/page/MessageViewer.es as main, " + mainRequire + "/components/cims-datepicker/CimsDatepickerModule.es as cdtp" %>">
    Liferay.cimsThemeDisplay = {
        organizationId: <%= (cimsOrganization == null)?"null": String.valueOf( cimsOrganization.getOrganizationId() ) %>,
        userId: <%= String.valueOf( themeDisplay.getUserId() ) %>,
        groupId: <%= String.valueOf(themeDisplay.getSiteGroupId())%>,
        userActions: {
        }
    };

    cdtp.default('<portlet:namespace />');
    main.default('<portlet:namespace />', Liferay.cimsThemeDisplay );
</aui:script>
